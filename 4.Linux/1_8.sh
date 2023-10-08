#!/bin/bash
read -p "Enter Directory Name: " dir_name
dir_path=$(find / -type d -name $dir_name)
echo "Files in Directory $dir_name: "
cd $dir_path || exit
ls

