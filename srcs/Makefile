# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yamajid <yamajid@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/15 15:29:04 by yamajid           #+#    #+#              #
#    Updated: 2024/09/17 00:03:00 by yamajid          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

D-C = docker-compose
C-F = docker-compose.yml

all: up

.PHONY: up
up:
	$(D-C) -f $(C-F) up --build
	
.PHONY: down
down:
	$(D-C) -f $(C-F) down -v

.PHONY: status
status:
	$(D-C) -f $(C-F) ps

.PHONY: shell-wordpress
shell-wordpress:
	$(D-C) -f $(C-F) exec wordpress bash
	
.PHONY: shell-nginx
shell-nginx:
	$(D-C) -f $(C-F) exec nginx bash

.PHONY: shell-mariadb
shell-mariadb:
	$(D-C) -f $(C-F) exec mariadb bash

.PHONY: clean
clean:
	$(D-C) -f $(C-F) down --volumes --remove-orphans
