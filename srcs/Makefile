# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yamajid <yamajid@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/15 15:29:04 by yamajid           #+#    #+#              #
#    Updated: 2024/10/10 16:15:21 by yamajid          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

D-C = docker-compose
C-F = docker-compose.yml

all: up

.PHONY: up down status shell-wordpress shell-nginx shell-mariadb clean rmv fclean
up:
	$(D-C) -f $(C-F) up --build

down:
	$(D-C) -f $(C-F) down -v

status:
	$(D-C) -f $(C-F) ps

shell-wordpress:
	$(D-C) -f $(C-F) exec wordpress bash

shell-nginx:
	$(D-C) -f $(C-F) exec nginx bash

shell-mariadb:
	$(D-C) -f $(C-F) exec  mariadb bash

clean:
	$(D-C) -f $(C-F) down --volumes --remove-orphans


rmv:
	rm -rf /home/yamajid/data/mariadb_data/*
	rm -rf /home/yamajid/data/wordpress_data/*

fclean: rmv
	docker system prune -a -f
