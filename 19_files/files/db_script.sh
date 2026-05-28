#!/bin/bash

dnf install mariadb1011-client-utils -y
aws s3 cp s3://s3-xxxxx-board/db_init.sql /tmp/db_init.sql

mariadb -h endpoint-xxxxxx -u root -p123 < /tmp/db_init.sql

sleep 6
shutdown -P now

