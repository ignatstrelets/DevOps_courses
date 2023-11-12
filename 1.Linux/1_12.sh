#!/bin/bash
file_path=$(find /var/log -type f -exec grep -l 'error' {} \; )
result_len="$(echo $file_path | wc -w)"
if (test $result_len -eq 0);
    then echo 'Files Matching "error" Not Found'
  else echo "$file_path"
fi
