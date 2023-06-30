output "lambda_function_name" {
  description = "Name of the lambda function"
  value = module.password_lambda.lambda_function_arn
  sensitive = true
}
