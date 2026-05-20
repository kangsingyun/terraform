<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the website, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wpDB' );

/** Database username */
define( 'DB_USER', 'wpadmin' );

/** Database password */
define( 'DB_PASSWORD', '123' );

/** Database hostname */
define( 'DB_HOST', 'database-wordpress.c1kik0yioi4k.ap-northeast-2.rds.amazonaws.com' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         '[X]Y~8Oh_?gAGsr=Z f~Q5|x?zkr+Zk`9Eh*n*~amg~djY<RNcG>{)wh^LnGI@Q^' );
define( 'SECURE_AUTH_KEY',  '1.1{K*13V+}YOLQ0LIe@OyA^XJWq/S!/(yeJS,:&WFZ8CT$DMGTJuXG3y/bD<PID' );
define( 'LOGGED_IN_KEY',    'iX w3Fu. _kBRDCuDdT=/DQ`5=Q`[P)adrQ-.2I[X+,cI:,5G5=8}T#.@CegS%CE' );
define( 'NONCE_KEY',        '#Jp14W(`<@kRa-?iYA5Sr8?0M&07]:cf=iDfWr8L7KVn2/%PP,2TZ2~=vZW6Ql&!' );
define( 'AUTH_SALT',        '8*|^vZZ7Dz<F.Xtl0+m0[3a?*%O<MI3A*=:*`8aPdO>e<X~!37`bMi[BV)vEAd/t' );
define( 'SECURE_AUTH_SALT', '=w@a2%Km.EJA`|qRNJd9RzTRLPrP^tDWUQ-L[(o4{CQ;O-yoevttCC~nk@pkg$:m' );
define( 'LOGGED_IN_SALT',   '>*3tK+5|Z}b?N)_EvK@a6DTflLw<86-P%EI0Y*&qnk!vC!abX%7hPE]hg 9AM{ji' );
define( 'NONCE_SALT',       'AAI3#pr$lKa^x9wIJRPsf6a:>aqNYGHnc.@Ml9^0$cM5nLUqH`szq*G0%L4V%Cg8' );

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 *
 * At the installation time, database tables are created with the specified prefix.
 * Changing this value after WordPress is installed will make your site think
 * it has not been installed.
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/#table-prefix
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://developer.wordpress.org/advanced-administration/debug/debug-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
