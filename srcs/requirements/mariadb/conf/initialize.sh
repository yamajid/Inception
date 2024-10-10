# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    initialize.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yamajid <yamajid@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/14 09:54:52 by yamajid           #+#    #+#              #
#    Updated: 2024/10/10 16:19:27 by yamajid          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

set -e


service mariadb start

echo "Waiting for MariaDB to be ready..."

mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
mysql -u root -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
mysql -u root -e "FLUSH PRIVILEGES;"

max_tries=15
counter=0

while ! mysql -u root -e "SELECT 1" > /dev/null 2>&1; do
    counter=$((counter+1))
    if [ $counter -gt $max_tries ]; then
        echo "MariaDB failed to start"
        exit 1
    fi
    sleep 1
done

sleep 5

echo "MariaDB is ready!"

mysqladmin -u root -p${DB_PASS} shutdown


exec mysqld_safe --datadir='/var/lib/mysql' --bind-address=0.0.0.0 --port=3306

