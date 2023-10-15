#!/bin/bash

find /tmp -type f -exec rm -f {} \;
find /var/tmp -type f -exec rm -f {} \;
rm -rf /home/$USER/.cache/*
message="$(date) Deleted deprecated temporary files $CLEAN_PERIOD days old on server $(hostname)."
echo "$message"