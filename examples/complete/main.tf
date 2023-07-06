data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

module "password_lambda" {
  source = "../../"
  timeout = 900
  function_name        = "password-reset-function"
  function_description = "Function to reset passwords for ec2 instances with tag Key: Password-Rotation Value: True"
  function_handler     = var.function_handler
  lambda_runtime       = "python3.9"
  policy_statements    =  {
  ec2 = {
    effect    = "Allow",
    actions   = ["ec2:DescribeInstances", "ec2:DescribeImages"]
    resources = ["*"]
    condition = {
      stringequals_condition = {
        test     = "StringEquals"
        variable = "aws:RequestedRegion",
        values   = "${var.region}",
        test     = "StringEquals"
        variable = "aws:PrincipalAccount"
        values   = "${data.aws_caller_identity.current.account_id}"
      }
    }
  },
  secretsmanager = {
    effect = "Allow",
    actions = [
      "secretsmanager:CreateSecret",
      "secretsmanager:PutResourcePolicy",
      "secretsmanager:DescribeSecret",
      "secretsmanager:UpdateSecret"
    ]
    resources = ["arn:aws-us-gov:secretsmanager:${var.region}:${data.aws_caller_identity.current.account_id}:*"]
  },
  logs = {
    effect = "Allow",
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws-us-gov:logs:${var.region}:${data.aws_caller_identity.current.account_id}:*"]
  },
  ssm = {
    effect = "Allow"
    actions = [
      "ssm:SendCommand",
      "ssm:GetCommandInvocation",
      "ssm:PutParameter",
      "ssm:GetParameter",
      "ssm:DeleteParameter"
    ]
    resources = [
      "arn:aws-us-gov:ec2:${var.region}:${data.aws_caller_identity.current.account_id}:instance/*",
      "arn:aws-us-gov:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:*",
      "arn:aws-us-gov:ssm:${var.region}::document/AWS-RunShellScript",
      "arn:aws-us-gov:ssm:${var.region}::document/AWS-RunPowerShellScript"
    ]
  },
}
  depends_on = [ data.archive_file.lambda_archive_file ]
  output_path = var.output_path
}

data "archive_file" "lambda_archive_file" {
  type        = "zip"
  source_file = var.source_file
  output_path = var.output_path
}

### Time sleep and lambda invocation is used in this scenario only if you are deploying a eks cluster. This assumes that your ec2 instances would be deployed and SSM agent running by the time the cluster creates. 
### At that time the function would execute to change the password for your instances shortly after creation. 

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
