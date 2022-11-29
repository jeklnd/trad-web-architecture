# 01 trad-web-architecture
This project is an implementation of a traditional three-tier web application architecture inspired by this design:
https://docs.aws.amazon.com/whitepapers/latest/web-application-hosting-best-practices/an-aws-cloud-architecture-for-web-hosting.html

Technologies used: Terraform, VPC, EC2, ELB, ASG, CloudFront, HTML, CSS, Git, Bash

# 02 Getting set up
Before running "terraform apply" for your own resume site, you must:
1.) input the variable values in section 03
2.) buy a domain and create a hosted zone in route53
3.) create a key pair following steps 1-3 in section 05

# 03 Inputting variable values:
The following commands must be executed before running terraform apply to input the values of the key_name and my_ip variables:
    – export TF_VAR_key_name="your-key-name-here"
    – export TF_VAR_my_ip="your-external-ip-address-here"
    – export TF_VAR_db_username="your-db-username-here"
    – export TF_VAR_db_password="your-db-password-here"

# 04 Building the architecture:
    – Change directories to the environment of choice, e.g. "cd ~/trad-web-architecture/environments/dev"
    – Run "terraform init"
    – Run "terraform plan"
    – Run "terraform apply" to review what resources will be created and type "yes"
    – Run "terraform destroy" to review what resources will be deleted and type "yes"

# 05 Securely accessing servers in private subnets with the bastion host
To access servers in private subnets with the bastion host from a Linux environment (e.g. WSL2), you must:

1.) Create a key pair:
    – Log in to the AWS Console, go to the EC2 service, and click "Key Pairs" under Network & Security
    – Click "Create key pair"
    – Enter the name–e.g. "bastion-key"–and select the key pair type and private key file format
    – Move the key pair to ~/.ssh, e.g. mv /file-path-to-key/bastion-key.pem ~/.ssh

2.) Change the permissions of the key:
    – Execute "sudo chmod 400 ~/.ssh/bastion-key.pem"
    – Enter your sudo pasword if prompted

3.) Enable the ssh-agent:
    – start the ssh-agent:  eval `ssh-agent -s` 
    – Add the key: ssh-add ~/.ssh/bastion-key.pem
    – Verify the key was added successfully: ssh-add -L

4.) Log in to the bastion host: ssh -v -A ec2-user@bastion.host.public.ipv4

5.) Log in to an ec2 instance in a private subnet from the bastion host: ssh -v -A ec2-user@ec2.instance.private.ipv4

