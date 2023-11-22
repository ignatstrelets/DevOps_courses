# Scripts
Scripts 1_7 to 1_13 are using global search via 'find' utility.
You need to have proper permissions (simply, to be authorized as 'root' or use 'sudo').

# Description of 1_13
Script 1_13 displays usage of disks on your host, also it provides an option of email notification and deletion of deprecated temporary files that are 'n' days old.

SYNOPSIS

        1_13.sh -ec

To set your email address, use flag "-e" (e.g. 'bash 1_13.sh -e john@doe.com')

To set a deprecation period, use flag "-c" (e.g. 'bash 1_13.sh -c +5')

Note: 

Files to be removed are searched via 'find' utility. 

Use 'mtime' syntax to define age of files to be deleted.

(e.g. Older than 5 days: '+5')

(e.g. 4 days old: '4')

