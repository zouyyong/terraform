#AWS provider 
provider "aws" {
  region = var.region
}

#state file backend 
terraform {
  backend "s3" {}
}


# Upload Lambda layer dependencies to the S3 bucket
resource "aws_s3_object" "lambda_layer" {
  bucket = var.lambda_bucket
  key    = "layers.zip"  # Update with your Lambda layer dependencies filename
  source = "python/layers.zip"  # Update with the  path to your Lambda layer dependencies
}

# Upload Lambda function file to the S3 bucket
resource "aws_s3_object" "lambda_code" {
  bucket = var.lambda_bucket
  key    = "lambda.zip"  # Update with your Lambda layer dependencies filename
  source = "python/lambda.zip"  # Update with the  path to your Lambda layer dependencies
}


# Create IAM role for Lambda function
resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# Attach basic execution policy to Lambda role
resource "aws_iam_role_policy_attachment" "lambda_execution_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}

# Attach S3 read access policy to Lambda role
resource "aws_iam_policy" "lambda_s3_policy" {
  name        = "lambda_s3_policy"
  description = "Policy to allow Lambda function access to S3 bucket"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "s3:GetObject"
      Resource  = "arn:aws:s3:::${var.lambda_bucket}/*"
    }]
  })
}

# Attach S3 policy to Lambda role
resource "aws_iam_role_policy_attachment" "lambda_s3_policy_attachment" {
  policy_arn = aws_iam_policy.lambda_s3_policy.arn
  role       = aws_iam_role.lambda_role.name
}

# Create Lambda function
resource "aws_lambda_function" "my_lambda_function" {
  function_name    = "my_lambda_function"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.8"
  role             = aws_iam_role.lambda_role.arn
  timeout          = 60  # Update with your desired timeout
  memory_size      = 128  # Update with your desired memory size
  source_code_hash = filebase64sha256("python/lambda.zip") 
  
  # S3 bucket location of Lambda code
  s3_bucket        = var.lambda_bucket
  s3_key           = aws_s3_object.lambda_code.key

  # Add Lambda layer for Python dependencies
  layers = [aws_lambda_layer_version.my_lambda_layer.arn]

  # CloudWatch Logs
  tracing_config {
    mode = "Active"
  }

  # Environment variables
  environment {
    variables = {
      "LOG_LEVEL" = "INFO"  # Example environment variable
    }
  }
}

# Create Lambda layer for Python dependencies
resource "aws_lambda_layer_version" "my_lambda_layer" {
  layer_name = "my_lambda_layer"
  s3_bucket  = var.lambda_bucket
  s3_key     = aws_s3_object.lambda_layer.key
  compatible_runtimes = ["python3.8"]
}
