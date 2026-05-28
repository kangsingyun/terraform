#!/bin/bash
dnf install httpd php8.4 php8.4-mysqlnd php8.4-pecl-redis6 -y
    
aws s3 cp s3://s3-511874874257-test-board/test_board.tar.gz /tmp/test_board.tar.gz
tar zxf /tmp/test_board.tar.gz -C /var/www/html
aws s3 cp s3://s3-511874874257-test-board/config.php /var/www/html/config.php
sleep 3
aws s3 cp s3://s3-511874874257-test-board/www.conf /etc/php-fpm.d/www.conf
sleep 3
systemctl restart httpd
systemctl enable httpd
