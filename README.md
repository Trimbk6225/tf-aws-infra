# tf-aws-infra
Terraform: Install Terraform on your local machine.
AWS CLI: Install and configure the AWS CLI on your system.



Set Up AWS CLI
	1.	Configure AWS CLI with aws configure.
	2.	Set up AWS credentials:
    Commands:-
        aws configure --profile <your-profile-name>

    1. Initialize Terraform
    Commands:-
        terraform init

    2. Plan Infrastructure
    Commands:-
        terraform plan -var-file=dev.tfvars

    3. Apply Configuration
        Commands:-
        terraform apply -var-file=dev.tfvars

    4. Destroy Infrastructure
    Commands:-
        terraform apply -var-file=dev.tfvars


For Assignment 5

I added iam_role.tf, rds.tf, rds-sg.tf file for s3 bucket and s



for this assignment   
i added autoscaling.tf, cloudwatch.tf, load_balance.tf, output.tf, route53,



import command


aws acm import-certificate --certificate fileb://www_demo_trimbkjagtap_me.crt --certificate-chain fileb://www_demo_trimbkjagtap_me.ca-bundle --private-key fileb://private.key