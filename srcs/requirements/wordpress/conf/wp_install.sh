# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    wp_install.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yamajid <yamajid@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/10 15:01:11 by yamajid           #+#    #+#              #
#    Updated: 2024/09/02 19:25:32 by yamajid          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

set -e

cd /var/www/html
    
if [ ! -f "/usr/local/bin/wp" ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

sleep 5

wp core download --path=/var/www/html/ --allow-root

wp config create --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER \
    --dbhost=$WORDPRESS_DB_HOST  --dbpass=$WORDPRESS_DB_PASSWORD --path=/var/www/html/  --allow-root
    
max_tries=15
counter=0

while mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent;
do
    sleep 1
    counter=$((counter + 1))
    if [ $counter -ge $max_tries ]; then
        echo "Error: MariaDB did not became ready in time."
        exit 1
    fi
    echo "Attempt $counter: Waiting for MariaDB to be ready..."
done

wp core install --url=$WORDPRESS_URL --title=$WORDPRESS_TITLE \
     --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD \
     --admin_email=$WORDPRESS_ADMIN_EMAIL --allow-root


wp user create $USER_NAME $USER_EMAIL --role=author --user_pass=$USER_PASSWORD --allow-root

sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

mkdir -p /run/php

exec php-fpm7.4 -F