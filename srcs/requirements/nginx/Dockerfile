# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yamajid <yamajid@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/07 11:47:27 by yamajid           #+#    #+#              #
#    Updated: 2024/09/02 19:36:33 by yamajid          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nginx openssl && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

RUN openssl req -x509 -nodes -keyout /etc/ssl/private/cert.key \
    -out /etc/ssl/certs/cert.crt -subj "/C=/ST=/L=/O=/OU=/CN=localhost"
    
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html && \
    chown www-data:www-data /var/www/html
    
CMD ["nginx"]