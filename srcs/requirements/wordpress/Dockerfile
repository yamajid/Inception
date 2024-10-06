# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yamajid <yamajid@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/08 14:08:18 by yamajid           #+#    #+#              #
#    Updated: 2024/09/26 03:25:17 by yamajid          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y && apt-get clean -y \
    && apt-get install php7.4 php7.4-fpm curl php7.4-mysql mariadb-client -y && \
    rm -rf /var/lib/apt/lists/*

COPY ./conf/wp_install.sh /var/www/html/wp_install.sh

RUN chmod 755 /var/www/html && \
    chown www-data:www-data /var/www/html

CMD ["/bin/sh", "/var/www/html/wp_install.sh"]