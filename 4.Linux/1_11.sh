#!/bin/bash
read -p "Enter File Name: " file_name
file_path=$(find / -type f -name $file_name)
result_len="$(echo $file_path | wc -w)"
if (test $result_len -gt 1 );
  then echo "Multiple Files With That Name"
elif (test $result_len -eq 0);
  then echo "File Not Found"
  else
    temp_file=$(mktemp)
    updated_text=$(cat $file_path | sed -e 's/error/warning/ig')
    echo "$updated_text" > "$temp_file"
    mv  "$temp_file" "$file_path" && echo 'All "error" strings are changed to "warning"'   || echo "Unknown error"
fi
