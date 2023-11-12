#!/bin/bash
ALERT=90
LOG_FILE=/var/log/disk_space_manager_log
review() {
  (df -H | grep -vE "^Filesystem|tmpfs|cdrom" | awk '{print $5 " " $6}' | review_by_line)
}
review_by_line() {
  while read -r line;
  do
  usage=$(echo "$line" | awk '{print $1}' | cut -d'%' -f1)
  disk=$(echo "$line" | awk '{print $2}')
  echo  "$disk" " usage is " "$usage"%
  if [ $usage -ge $ALERT ] ; then
        message="$(date) Running out of space $disk ($usage%) on server $(hostname)."
        log $message
        if [ ! -z $EMAIL ] ; then
        email "Warning: $usage% of $disk is in use." "$message"
      fi
  fi
  if [ ! -z $CLEAN_PERIOD ] ; then
              clean
  fi


  done

}
log() {
        echo "$@" >> $LOG_FILE
}
clean() {
  find /tmp -type f -mtime $CLEAN_PERIOD -exec rm -f {} \;
  find /var/tmp -type f -mtime $CLEAN_PERIOD -exec rm -f {} \;
  rm -rf /home/$USER/.cache/*
  message="$(date) Deleted deprecated temporary files $CLEAN_PERIOD days old on server $(hostname)."
  if [ ! -z $EMAIL ] ; then
          email 'Deleted deprecated temporary files.' "$message"
  fi
  log $message
}
email() {
        mail -s "$1" $EMAIL <<< "$2"
}
if [ !  -f $LOG_FILE ]; then
        touch $LOG_FILE
fi


while getopts e:c: flag
do
        case "${flag}" in
                e) EMAIL=${OPTARG};;
                c) CLEAN_PERIOD=${OPTARG};;
                *);;
        esac
done

review
