#!/bin/bash

# update and upgrade alpine package manager
apk update && apk upgrade

# install nginx
apk add nginx

# add user
adduser -D -g 'www' www

# make new directory and change permissions
mkdir /www && chown -R www:www /var/lib/nginx && chown -R www:www /www
