# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    wp_install.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yamajid <yamajid@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/10 15:01:11 by yamajid           #+#    #+#              #
#    Updated: 2024/10/10 16:16:08 by yamajid          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


#!/bin/bash

set -e

max_tries=15
counter=0

# Wait for MariaDB to be ready
until mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
    sleep 1
    counter=$((counter + 1))
    echo "Attempt $counter: Waiting for MariaDB to be ready..."
    if [ $counter -ge $max_tries ]; then
        echo "Error: MariaDB did not become ready in time."
        exit 1
    fi
done

# Download WordPress core if not already downloaded
if [ ! -f wp-config.php ]; then
    echo "Downloading WordPress..."
    wp core download --allow-root
    wp config create --dbname="$WORDPRESS_DB_NAME" --dbuser="$WORDPRESS_DB_USER" \
        --dbhost="$WORDPRESS_DB_HOST" --dbpass="$WORDPRESS_DB_PASSWORD" --allow-root
fi

# Check if WordPress is already installed
if wp core is-installed --allow-root; then
    echo "WordPress is already installed."
else
    echo "WordPress is not installed."
    wp core install --url="$WORDPRESS_URL" --title="$WORDPRESS_TITLE" \
        --admin_user="$WORDPRESS_ADMIN_USER" --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL" --allow-root

fi

if wp user get "$USER_NAME" --allow-root >/dev/null 2>&1; then
    echo "User '$USER_NAME' already exists."
else
    echo "Creating user '$USER_NAME'..."
    wp user create "$USER_NAME" "$USER_EMAIL" --role=author --user_pass="$USER_PASSWORD" --allow-root
fi

sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

exec php-fpm7.4 -F