#!/bin/bash
read -p "Enter File Name: " file_name
file_path=$(find / -type f -name $file_name)
echo "Contents of File $file_name: "
cat $file_path || exit
