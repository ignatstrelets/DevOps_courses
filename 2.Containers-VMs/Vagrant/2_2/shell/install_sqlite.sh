#!/bin/bash

# update and upgrade alpine package manager
apk update && apk upgrade

# install SQLite
apk add --no-cache sqlite