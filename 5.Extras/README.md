# Extras

[1. Nginx configured as caching reverse proxy](nginx)

[2. Apache configured as caching reverse proxy](apache)

[3. Nginx configured as reverse proxy + Apache as caching reverse proxy](nginx+apache)

[4. Temporary files cleaning cronjob configuration](clean_14d_5mb.md)

##### 5. Wappalyzer: Wordpress installed with helm
![5. Wappalyzer: Wordpress installed with helm](wappalyzer/wordpress/wappalyzer-php.png)

##### 6. Wappalyzer: Hide Apache and Nginx Versions
###### NOTE: php in task 6 is omitted due to php version is initially hidden 

 a) Nginx+Nginx (nginx frontend and backend versions are hidden)
![6. Wappalyzer: Nginx+Nginx](wappalyzer/nginx/wappalyzer-nginx-hidden.png)

 b) Nginx+Apache (apache backend is hidden; due to unknown reason backend apache is shown as nginx)
![6. Wappalyzer: Nginx+Apache](wappalyzer/nginx+apache/wappalyzer-nginx+apache-hidden.png)

##### 7. Linux

 a) mount only two loopback devices
![7. 1](linux/linux-1.png)

 b) mount all loopback devices
![7. 2](linux/linux-2.png)

##### 8. Jenkins
###### [Jenkinsfile](jenkins/Jenkinsfile)

![8. Jenkins](jenkins/jenkins.png)