resource "local_file" "db_script" {
    content = <<-EOF
    #!/bin/bash

    dnf install mariadb1011-client-utils -y
    aws s3 cp s3://s3-${var.account_id}-${var.s3_subname}/${var.file_map.sql.key} /tmp/${var.file_map.sql.key}

    mariadb -h ${var.rds_address} -u ${var.username} -p${var.password} < /tmp/${var.file_map.sql.key}

    sleep 6
    shutdown -P now

  EOF
    filename = "../../project/files/${var.file_map.db_script.key}"
}
resource "local_file" "web_script" {
    content = <<-EOF
    #!/bin/bash
    dnf install httpd php8.4 php8.4-mysqlnd php8.4-pecl-redis6 -y
    
    aws s3 cp s3://s3-511874874257-board/test_board.tar.gz /tmp/test_board.tar.gz
    tar zxf /tmp/test_board.tar.gz -C /var/www/html
    aws s3 cp s3://s3-${var.account_id}-${var.s3_subname}/${var.file_map.config.key} /var/www/html/${var.file_map.config.key}
    sleep 3
    aws s3 cp s3://s3-${var.account_id}-${var.s3_subname}/${var.file_map.www_conf.key} /etc/php-fpm.d/${var.file_map.www_conf.key}
    sleep 3
    systemctl restart httpd
    systemctl enable httpd
  EOF
    filename = "../../project/files/${var.file_map.web_script.key}"
}
resource "local_file" "sql" {
  content = <<-EOF
    DROP DATABASE IF EXISTS ${var.database.db_name};
    DROP USER IF EXISTS '${var.database.username}'@'${var.database.hostname}';

    CREATE USER '${var.database.username}'@'${var.database.hostname}' IDENTIFIED BY '${var.database.password}';
    GRANT ALL PRIVILEGES ON ${var.database.db_name}.* TO '${var.database.username}'@'${var.database.hostname}';
    CREATE DATABASE ${var.database.db_name} DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    USE ${var.database.db_name};
    CREATE TABLE users (username CHAR(16) NOT NULL PRIMARY KEY, password CHAR(41));

    INSERT INTO users VALUES ('user1', '1234');
    INSERT INTO users VALUES ('user2', '1234');

    CREATE TABLE board (
    id INT UNSIGNED AUTO_INCREMENT,
    user VARCHAR(100) NOT NULL,
    title VARCHAR(100) NOT NULL,
    comment TEXT NOT NULL,
    file VARCHAR(100),
    date DATETIME NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (user) REFERENCES users (username));

  EOF
  filename = "../../project/files/${var.file_map.sql.key}"
}
resource "local_file" "config" {
  content = <<-EOF
  <?php

	$site_title = 'Test Board';

	define('ALLOW_SCRIPT_TAGS', true);
	//$site_title = htmlspecialchars(gethostname(), ENT_QUOTES, 'UTF-8');

	define('DB_HOST', '${var.rds_address}');
	define('DB_USER', '${var.database.username}');
	define('DB_PASSWORD', '${var.database.password}');
	define('DB_NAME', '${var.database.db_name}');
	define('DB_CHARSET', 'utf8mb4');

	function db_connect()
	{
		$con = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);

		if(!$con)
			die('Database connection failed: '.mysqli_connect_error());

		mysqli_set_charset($con, DB_CHARSET);

		return $con;
	}

	function render_post_content($content)
	{
		if(ALLOW_SCRIPT_TAGS)
			return nl2br($content, false);

		return nl2br(htmlspecialchars($content, ENT_QUOTES, 'UTF-8'), false);
	}

  ?>

  EOF
  filename = "../../project/files/${var.file_map.config.key}"
}
resource "local_file" "www_conf" {
  content = <<-EOF
    [www]
    user = apache
    group = apache
    listen = /run/php-fpm/www.sock
    listen.acl_users = apache,nginx
    listen.allowed_clients = 127.0.0.1
    pm = dynamic
    pm.max_children = 50
    pm.start_servers = 5
    pm.min_spare_servers = 5
    pm.max_spare_servers = 35
    slowlog = /var/log/php-fpm/www-slow.log
    php_admin_value[error_log] = /var/log/php-fpm/www-error.log
    php_admin_flag[log_errors] = on
    php_value[session.save_handler] = redis
    php_value[session.save_path]    = "tls://${var.cache_endpoint.address}:${var.cache_endpoint.port}?cluster=1"
  EOF
  filename = "../../project/files/${var.file_map.www_conf.key}"
}