# Terraform Lambda Module Example

This Terraform module provisions an AWS Lambda function with associated resources.

## Features

- Creates an AWS Lambda function that reset passwords based on tag on instance of Password-Rotation: True
- Uncomment the below fields in main.tf to initial an initial password rotation based on eks module being deployed. 
```
 resource "time_sleep" "delay" {
   depends_on = [module.eks]

   create_duration = "2m"
 }

 resource "aws_lambda_invocation" "initial_password_change" {
   depends_on = [ module.password_lambda ]
   function_name = module.password_lambda.lambda_function_arn
   input = <<JSON
   {
     "key1": "value1",
     "key2": "value2"
   }
   JSON
 }
```
- Supports attaching an IAM policies to lambda role
- This function relies on ssm agent to be running on ec2 instances. 
 
