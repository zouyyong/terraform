AWS Infrastructure as Code with Terraform and Terragrunt
This repository contains Terraform and Terragrunt code to provision a simple AWS environment. The infrastructure includes an S3 bucket with encryption, logging, intelligent tiering, and replication to a secondary region, as well as a Lambda function that pulls code and dependencies from the S3 bucket, includes a layer for python library dependencies, and logs to CloudWatch.

Project Structure
The project follows a modular structure to organize Terraform configurations efficiently:

css
Copy code
.
├── terragrunt.hcl
├── terragrunt.tfvars
└── modules
    ├── s3_bucket
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── lambda_function
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
terragrunt.hcl: Terragrunt configuration file.
terragrunt.tfvars: Terragrunt variables file.
modules/s3_bucket/main.tf: Terraform code for provisioning the S3 bucket.
modules/s3_bucket/variables.tf: Input variables for the S3 bucket module.
modules/s3_bucket/outputs.tf: Output values for the S3 bucket module.
modules/lambda_function/main.tf: Terraform code for provisioning the Lambda function.
modules/lambda_function/variables.tf: Input variables for the Lambda function module.
modules/lambda_function/outputs.tf: Output values for the Lambda function module.
How to Run
To deploy the infrastructure, follow these steps:

Install Terraform and Terragrunt.
Clone this repository.
Navigate to the modules/s3_bucket directory and update variables.tf with your desired configuration.
Navigate to the modules/lambda_function directory and update variables.tf with your desired configuration.
Navigate back to the root directory containing terragrunt.hcl and terragrunt.tfvars.
Run terragrunt apply to deploy the infrastructure.
Additional Information
The Terraform code is designed to be modular, maintainable, and follows best practices.
AWS credentials are assumed to be configured separately outside of this project.
This project assumes an existing VPC is available for resource provisioning.
Security group rules should be reviewed and adjusted according to specific requirements and best practices.
Feel free to reach out if you have any questions or encounter any issues!