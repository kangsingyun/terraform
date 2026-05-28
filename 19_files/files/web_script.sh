#!/bin/bash
dnf install httpd php8.4 php8.4-mysqlnd -y
    
aws s3 cp s3://s3-511874874257-board/test_board.tar.gz /tmp/test_board.tar.gz
tar zxf /tmp/test_board.tar.gz -C /var/www/html
aws s3 cp s3://s3-xxxxx-board/config.php /var/www/html/config.php

systemctl restart httpd
systemctl enable httpd
