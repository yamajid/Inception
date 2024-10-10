# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yamajid <yamajid@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/09 21:48:00 by yamajid           #+#    #+#              #
#    Updated: 2024/10/10 16:19:10 by yamajid          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y mariadb-server && apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*


COPY ./conf/initialize.sh /usr/local/bin/initialize.sh

RUN chmod +x /usr/local/bin/initialize.sh

CMD ["/bin/sh", "/usr/local/bin/initialize.sh"]
