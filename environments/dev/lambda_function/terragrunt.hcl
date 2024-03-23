# include top level  terragrunt file 
include "root" {
  path = find_in_parent_folders()
}

# include modules 
terraform {
  source = "../../../modules/lambda_function"
}