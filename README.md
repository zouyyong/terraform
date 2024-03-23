# AWS Infrastructure as Code with Terraform and Terragrunt

This repository contains Terraform and Terragrunt code to provision a simple AWS environment. The infrastructure includes an S3 bucket with encryption, logging, intelligent tiering, and replication to a secondary region, as well as a Lambda function that pulls code and dependencies from the S3 bucket, includes a layer for python library dependencies, and logs to CloudWatch.

## Project Structure
The project follows a modular structure to organize Terraform configurations efficiently:

```
environments
   |-- dev
   |   |-- lambda_function
   |   |   |-- terragrunt.hcl
   |   |-- s3_bucket
   |   |   |-- terragrunt.hcl
   |   |-- terragrunt.hcl
modules
   |-- lambda_function
   |   |-- main.tf
   |   |-- output.tf
   |   |-- python
   |   |   |-- lambda.zip
   |   |   |-- layers.zip
   |   |-- variables.tf
   |-- s3_bucket
   |   |-- main.tf
   |   |-- output.tf
   |   |-- variables.tf
output
   |-- lambda_apply_output.txt
   |-- lambda_plan_output.txt
   |-- s3_apply_output.txt
   |-- s3_plan_outut.txt
```

environments/: contains a list of environments. This example only contains dev environment. It includes two modules. The top level terragrunt.hcl defined sharable parameters. 
terragrunt.hcl: Terragrunt configuration file.
modules/s3_bucket/main.tf: Terraform code for provisioning the S3 bucket.
modules/s3_bucket/variables.tf: Input variables for the S3 bucket module.
modules/s3_bucket/outputs.tf: Output values for the S3 bucket module.
modules/lambda_function/main.tf: Terraform code for provisioning the Lambda function.
modules/lambda_function/variables.tf: Input variables for the Lambda function module.
modules/lambda_function/outputs.tf: Output values for the Lambda function module.
modules/lambda_function/python/lambda.zip: lambda function zip file 
modules/lambda_function/python/layers.zip: lambda layer zip file 

## How to Run
To deploy the infrastructure, follow these steps:

Install Terraform and Terragrunt.
Setup AWS credentials and AWS cli 
Clone this repository.
Navigate to the environments/dev directory and update variables defined in terragrunt.hcl
Go to environments/dev/s3_bucket, Run terragrunt plan and terragrunt apply to deploy the s3 bucket.
Go to environments/dev/lambda_function, Run terragrunt plan and terragrunt apply to deploy the lambda bucket.

### Additional Information
The Terraform code is designed to be modular, maintainable, and follows best practices.
IAM User's permission should be adjusted accordingly, for example, need permission for S3, lambda. IAM
The output folder includes the running logs for successful execution of both S3 and lambda 

Feel free to reach out if you have any questions or encounter any issues!
