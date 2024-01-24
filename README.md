Description:

This project consists of 3 main directories;

    - ansible which contains all the files and directories needed to setup and configure the website on the VMs
    - backend_setup, which contains all the files needed to create a file on the "infra" directory which will create an s3 bucket each time you create the infrastructure. the point of the s3 bucket is to store the terraform state file and act as an secure remote storage.
    - infra, which contains all the files and directories needed to setup an infrastructure to host the website. This will create a VPC, route table, internet gateway, 4 subnets, 3 security groups, 2 EC2 instances and one RDS instance
    
Explaining the subdirectories and files:
    - ansible:
        - ansible.cfg is the main configuration file for ansible telling where the inventory folder is lcoated and the necessary plugins for ansible to run successfully.
        - inventory/hosts_aws_ec2.yaml is the file with a list of hosts and groups to manage with ansible
        - roles:
            - ansible has a feature called roles which allows users to breakup complex playbooks into smaller more digestable compontents, each directory under roles is named by where the task will be executed (although it could be named any way, I chose to name them like this as its clearer for me.)
            - each directory under the roles subdirectories will have a:
                - Tasks, this is where the main tasks that the role executes are located.
                - files, this is where the files to be deployed by the role is located.
                - templates, this is where the template to be deployed by the role is located.
                - vars, this is where a file containing variables to be used by the play will be located
        - app_setup.yaml is the main playbook that will be executed, it contains the roles that will be executed with each play and the hosts that the plays will be executed on
    - infa:
        - terraform is structured with modules to make writing code for multiple of the same structures simpler
        - under modules will be where the nested modules are locaed, the nested modules are used to split complex tasks down to smaller catagories. submodules are named after what each code used to create a part of the infrastructure is located. Terraform_ec2 holds code to create Ec2 instances (web instance and backend instance) and the RDS, terraform_security_group holds the code to create security groups and add security group rules for each subnet, terraform_vpc holds the code that creates all the other infrastructures required, such as the VPC itself, route tables, subnets, internet gateway.
        - under each nested modules there are 3 .tf files, main.tf which hosts the main code to create the part of the infrastructure, variables.tf is where the varibles expected by the main.tf file is located, outputs.tf is where the declaration for outputs variables are located, those can be called and used by other modules and the root main.tf itself.
        - provider.tf is where the service provider is located, i.e: hashicorp/aws
        - variables.tf is where the varibles expected by the main.tf file is located
        - main.tf is the root main.tf file, it holds the code that runs each module and defines the required the variables
    - backend_setup:
        - backend_setup is used to create the backend that stores terraform state files. it will output a file called "backend_config.tf" under infra that will create an s3 bucket which stores the terraform state files.
___________________________________________
How to run all the provisioning and code:

Step 1, setup the backend for your terraform state
    - Navigate to the "backend_setup" directory
    - execute the "terraform apply" command to setup a backend your terraform state files, this will create a backend_config.tf file in your infra folder.
Step 2, setup your infrastructure
    - Navigate to "infra" directory
    - execute the "terraform apply" command to create your VPC and setup the infrastructure. This will also create a backend S3 bucket which stores the terraform.tfstate file
    (Note, running terraform apply again after applying once will cause an error updating VPC Security Rules group, this error is caused by trying to open all ports to and from a security group more than once, this is a well known bug and can be safely ignored.)
Step 3, configure the application using ansible
    - Navigate to "ansible" directory
    - execute the "ansible-playbook app_setup.yaml" command
Done! now you may navigate to the Public IPv4 DNS of the a03_web_server to see the website.
___________________________________________
Requirements:

- you should have an AWS account
- you should have an IAM user on AWS that have the following permissions:
    - AdministratorAccess-Amplify
    - AmazonDynamoDBFullAccess
    - AmazonEC2FullAccess
    - AmazonRDSFullAccess
    - AmazonRoute53FullAccess
    - AmazonS3FullAccess
    - AmazonVPCFullAccess
    - IAMUserChangePassword
- Ansible should be installed
- terraform should be installed
- ssh should be configured in a way where you should be able to access the different VMs with names ending in "compute.amazonaws.com" without having to specify username and keyfile each time
- "Terraform init" should be executed on both the "backend_setup" and the "infra" directories.
- A repository on GitHub hosting the main code for the website.
(This project uses the code from "https://github.com/timoguic/acit4640-py-mysql.git") Its a simple website that uses JavaScript to retrieve the name and ID from a table located on mysql.
___________________________________________
