# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yamajid <yamajid@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/08 14:08:18 by yamajid           #+#    #+#              #
#    Updated: 2024/08/29 13:02:04 by yamajid          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y && apt-get clean -y \
    && apt-get install php7.4 php7.4-fpm curl php7.4-mysql mariadb-client -y && \
    rm -rf /var/lib/apt/lists/*

COPY ./conf/wp_install.sh /var/www/html/wp_install.sh

RUN chmod 755 /var/www/html/wp_install.sh && \
    chown -R www-data:www-data /var/www/html

EXPOSE 9000

CMD ["/bin/sh", "/var/www/html/wp_install.sh"]