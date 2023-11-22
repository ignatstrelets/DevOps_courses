# Wordpress+NodeJS App Configuration and Deployment via Bash and Terraform
###### (wordpress and node are listening to the same one port and requests are redirected depending on path)

##### 1. Configure App Server via Bash Script 
###### [configure.sh](configure.sh)

###### Test App Deployment on EC2
![node-test.png](screenshots%2Fapp%2Fnode-test.png)
![wp-test.png](screenshots%2Fapp%2Fwp-test.png)
###### (and make an AMI from EC2 Instance to reuse it)

##### 2. Deploy App Server with ALB to existing VPC
###### (Prerequisites: add tag "Tier: Public" to find public subnets in existing VPC via Terraform)
![add-tag-for-subnet.png](screenshots%2Fterraform%2Fadd-tag-for-subnet.png)
###### We're not able to make dropdown list in Terraform, but we can implement parameter constraints with error message
![tf-constraints.png](screenshots%2Fterraform%2Ftf-constraints.png)
###### Terraform Outputs
![show-outputs.png](screenshots%2Fterraform%2Fshow-outputs.png)
###### Test App Server with ALB
![test-node.png](screenshots%2Fterraform%2Ftest-node.png)
![test-wp.png](screenshots%2Fterraform%2Ftest-wp.png)





###### NOTE: Solution reference on making ALB Health Check for 2 apps listening to one port
![reference.png](screenshots%2Fapp%2Freference.png)