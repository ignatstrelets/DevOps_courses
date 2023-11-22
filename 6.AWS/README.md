# Manual AWS Configuration 

##### 1. VPC
![vpc.png](1.%20vpc%2Bsubnets%2Fvpc.png)
##### 2. Security Groups
![sg-inbound.png](2.%20security%20groups%2Fsg-inbound.png)
![sg-outbound.png](2.%20security%20groups%2Fsg-outbound.png)
![sg.png](2.%20security%20groups%2Fsg.png)
##### 3. Key Pair
![rsa.png](3.%20rsa%2Frsa.png)
##### 4. EC2
![ec2-overview.png](4.%20ec2%2Fec2-overview.png)
###### Get Public IP
![match-ip-console.png](4.%20ec2%2Fmatch-ip-console.png)
###### Connect via SSH using Public IP (hostname is equal to Private IP)
![match-ip-ssh.png](4.%20ec2%2Fmatch-ip-ssh.png)
##### 5. ELB
![elb-overview.png](5.%20elb%2Felb-overview.png)
![elb-healthcheck.png](5.%20elb%2Felb-healthcheck.png)
![elb-status.png](5.%20elb%2Felb-status.png)
###### Update Security Group Inbound rules for EC2
![sg-update.png](5.%20elb%2Fsg-update.png)
###### Test
![elb-http-test1.png](5.%20elb%2Felb-http-test1.png)
![elb-http-test2.png](5.%20elb%2Felb-http-test2.png)
##### 6. RDS
![rds-overview.png](6.%20rds%2Frds-overview.png)
![rds-connections.png](6.%20rds%2Frds-connections.png)
###### Test RDS connection via postgres CLI
![rds-test-1.png](6.%20rds%2Frds-test-1.png)
![rds-test2.png](6.%20rds%2Frds-test2.png)
##### 7. ElastiCache
###### Test Redis connection
![redis-test1.png](7.%20elasticache%2Fredis-test1.png)
![redis-test2.png](7.%20elasticache%2Fredis-test2.png)
###### Test Memcached connection
![memc-test1.png](7.%20elasticache%2Fmemc-test1.png)
![memc-test2.png](7.%20elasticache%2Fmemc-test2.png)
##### 8. CloudFront Distribution
![cloudfront-overview.png](8.%20cloudfront%20distribution%2Fcloudfront-overview.png)
###### Policy for CloudFront
![s3-policy.png](8.%20cloudfront%20distribution%2Fs3-policy.png)
###### Create 100 objects
![s3-objects.png](8.%20cloudfront%20distribution%2Fs3-objects.png)
###### Attemption to connect (due to public access is restricted)
![cloudfront-attempt.png](8.%20cloudfront%20distribution%2Fcloudfront-attempt.png)
###### Lifecycle Rules (Glacier on 30 days; deletion after 180 days)
![s3-glacier.png](8.%20cloudfront%20distribution%2Fs3-glacier.png)
![s3-deletion.png](8.%20cloudfront%20distribution%2Fs3-deletion.png)
![s3-rules-overview.png](8.%20cloudfront%20distribution%2Fs3-rules-overview.png)
##### 9. Script
###### [s3ctl](9.%20script%2Fs3ctl)
###### Create policy and grant IAM Role to EC2 Instance
![s3-policy.png](9.%20script%2Fs3-policy.png)
![add-role.png](9.%20script%2Fadd-role.png)
###### Test AWS CLI
a) delete
![test-delete.png](9.%20script%2Ftest-delete.png)
![test-delete-check.png](9.%20script%2Ftest-delete-check.png)
b) put
![test-put.png](9.%20script%2Ftest-put.png)
![test-put-check.png](9.%20script%2Ftest-put-check.png)
###### Test script
![script-test.png](9.%20script%2Fscript-test.png)
##### 10. Autoscaling Group
![asg-overview.png](10.%20autoscaling%20group%2Fasg-overview.png)
![asg-elb.png](10.%20autoscaling%20group%2Fasg-elb.png)
###### Target Scaling: Can't implement Step Scaling via Console due to this option is deprcated (CLI only) 
![asg-scaling.png](10.%20autoscaling%20group%2Fasg-scaling.png)
##### 11. Elastic Beanstalk
Single-container solution using cloud-native reverse proxy: [dockerrun.aws.json](11.%20beanstalk%2Fdockerrun.aws.json)
###### Test Docker image locally 
![test-docker-image.png](11.%20beanstalk%2Ftest-docker-image.png)
###### Setup environment via CloudShell
![eb-setup-via-cloudshell.png](11.%20beanstalk%2Feb-setup-via-cloudshell.png)
###### Environment
![eb-env.png](11.%20beanstalk%2Feb-env.png)
###### Test connection
![eb-test.png](11.%20beanstalk%2Feb-test.png)
##### 12. Jenkins
[Jenkinsfile](12.%20jenkins%2FJenkinsfile)
![jenkins-configure-scm.png](12.%20jenkins%2Fjenkins-configure-scm.png)
![jenkins-path.png](12.%20jenkins%2Fjenkins-path.png)
![successful-deploy-log.png](12.%20jenkins%2Fsuccessful-deploy-log.png)
