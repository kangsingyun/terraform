#!/bin/bash
dnf install httpd php8.4 php8.4-mysqlnd -y
wget https://ko.wordpress.org/wordpress-6.9.4-ko_KR.tar.gz
tar zxf wordpress-6.9.4-ko_KR.tar.gz
mv wordpress/* /var/www/html
rm -rf wordpress *.gz
aws s3 cp s3://s3-511874874257-wordpress/wp-config.php /var/www/html/wp-config.php
systemctl restart httpd.service
systemctl enable httpd.service