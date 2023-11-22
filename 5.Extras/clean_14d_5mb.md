## temporary files cleaning cronjob configuration
##### e.g. clean files in '/tmp' older than 14 days and larger than 5MB
#####
##### open root's crontab
```
sudo crontab -e
```
##### add cronjob
```
0 0 1,15 * * find /tmp -mtime +14 -type f -size +5M -delete
```
##### view root's crontab 
```
sudo crontab -u root -l
```
```
0 0 1,15 * * find /tmp -mtime +14 -type f -size +5M -delete
```