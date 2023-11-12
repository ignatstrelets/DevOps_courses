#!/bin/bash
FILE=~/my_file.txt
if test -f "$FILE"; then
    rm ~/my_file.txt && echo "The File Was Removed"
fi