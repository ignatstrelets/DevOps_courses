#!/bin/bash
FILE=~/my_file.txt
if test -f "$FILE"; then
    mv ~/my_file.txt /tmp/my_file.txt && echo " The File Was Replaced"
fi