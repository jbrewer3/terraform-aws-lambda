module "password_lambda" {
  source = "../../"
  
  function_name        = "password-reset-function"
  function_description = "Function to reset passwords for ec2 instances with tag Key: Password-Rotation Value: True"
  function_handler     = var.function_handler
  lambda_runtime       = "python3.9"
  policy_statements = var.policy_statements
  depends_on = [ data.archive_file.lambda_archive_file ]
  output_path = var.output_path
}

data "archive_file" "lambda_archive_file" {
  type        = "zip"
  source_file = var.source_file
  output_path = var.output_path
}

# resource "time_sleep" "delay" {
#   depends_on = [module.eks]

#   create_duration = "2m"
# }

# resource "aws_lambda_invocation" "initial_password_change" {
#   depends_on = [ module.password_lambda ]
#   function_name = module.password_lambda.lambda_function_arn
#   input = <<JSON
#   {
#     "key1": "value1",
#     "key2": "value2"
#   }
#   JSON
# }
