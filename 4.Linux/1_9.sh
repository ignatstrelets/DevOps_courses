#!/bin/bash
read -p "Enter File Name: " file_name
file_path=$(find / -type f -name $file_name)
result_len="$(echo $file_path | wc -w)"
if (test $result_len -gt 1 );
  then echo "Multiple Files With That Name"
elif (test $result_len -eq 0);
  then echo "File Not Found"
  else
    echo "Contents of File $file_name: "
    echo $(cat $file_path)
fi
