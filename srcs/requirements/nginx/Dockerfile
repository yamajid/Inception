# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yamajid <yamajid@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/07 11:47:27 by yamajid           #+#    #+#              #
#    Updated: 2024/08/29 13:11:13 by yamajid          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
    apt-get clean -y && \
    apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

RUN openssl req -x509 -nodes -keyout /etc/ssl/private/cert.key \
    -out /etc/ssl/certs/cert.crt -subj "/C=/ST=/L=/O=/OU=/CN=localhost"
    
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
    
CMD ["nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;"]