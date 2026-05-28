 <?php

//$site_title = 'Test Board';

define('ALLOW_SCRIPT_TAGS', true);
$site_title = htmlspecialchars(gethostname(), ENT_QUOTES, 'UTF-8');

define('DB_HOST', 'database-board.c1kik0yioi4k.ap-northeast-2.rds.amazonaws.com');
define('DB_USER', 'webmaster');
define('DB_PASSWORD', '123');
define('DB_NAME', 'test_board');
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

