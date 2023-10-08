#!/bin/bash
read -p "Enter Directory Name: " dir_name
dir_path=$(find / -type d -name $dir_name)
result_len="$(echo $dir_path | wc -w)"
if (test $result_len -gt 1 );
  then echo "Multiple Directories With That Name"
  elif (test $result_len -eq 0);
    then echo "Directory Not Found"
  else
    echo "Files in Directory $dir_name: "
    cd $dir_path
    ls
fi
