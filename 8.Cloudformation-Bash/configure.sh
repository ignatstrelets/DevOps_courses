#!/bin/bash

#Host OS: CentOS 8

#NOTE: add your custom data

sudo sh -c "
yum -y update

yum -y install httpd
systemctl enable httpd

dnf -y install mysql-server
systemctl start mysqld.service
systemctl enable mysqld.service

rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf install -y https://rpms.remirepo.net/enterprise/remi-release-8.rpm
dnf module enable php:remi-7.4 -y
dnf install -y php php-mysqlnd

cat > /home/centos/.my.cnf <<EOF
[client]
user = root
password =
EOF

touch /home/centos/wp.sql
cat > /home/centos/wp.sql <<EOF
CREATE DATABASE wordpress CHARACTER SET utf8 COLLATE utf8_bin;
CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY '<your_custom_password>';
GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost;
FLUSH PRIVILEGES;
EOF

mysql < ~/wp.sql

yum -y install wget

wget http://wordpress.org/latest.tar.gz

tar -xzvf latest.tar.gz

cat > home/centos/wordpress/wp-config.php <<EOF
<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/documentation/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'wordpressuser' );

/** Database password */
define( 'DB_PASSWORD', '<your_custom_password>' );

/** Database hostname */
define( 'DB_HOST', 'localhost' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

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
define('AUTH_KEY',         '<your_custom_value>');
define('SECURE_AUTH_KEY',  '<your_custom_value>');
define('LOGGED_IN_KEY',    '<your_custom_value>');
define('NONCE_KEY',        '<your_custom_value>');
define('AUTH_SALT',        '<your_custom_value>');
define('SECURE_AUTH_SALT', '<your_custom_value>');
define('LOGGED_IN_SALT',   '<your_custom_value>');
define('NONCE_SALT',       '<your_custom_value>');
/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
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
 * @link https://wordpress.org/documentation/article/debugging-in-wordpress/
 */
/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */
define(‘WP_DEBUG’, true);
define(‘WP_DEBUG_LOG’, true);
define(‘WP_DEBUG_DISPLAY’, true);
define( 'SCRIPT_DEBUG', true );

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
EOF

mkdir /var/www/html/blog/
cp -r /home/centos/wordpress/* /var/www/html/blog/

systemctl restart httpd mysqld



curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

nvm install 18
nvm use 18

dnf install -y git

npm install -g gatsby-cli

mkdir /home/centos/gatsby-projects
cd /home/centos/gatsby-projects

gatsby new my-hello-world-starter https://github.com/gatsbyjs/gatsby-starter-hello-world
cd my-hello-world-starter
"
gatsby develop --host="<your_internal_ip>"

#"

##

##
