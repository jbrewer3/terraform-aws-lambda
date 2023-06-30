# CloudWatch Event Rule

resource "aws_cloudwatch_event_rule" "cron_eventbridge_rule" {
  name                = "${var.prefix-name}-Cron-Password-Reset-Trigger"
  description         = "Monthly trigger for lambda function"
  schedule_expression = "cron(0 0 1 * ? *)"
  # depends_on = [ aws_lambda_function.lambda_password_function ]
  event_pattern = <<EOF
{
  "detail-type": [
    "Scheduled Event"
  ],
  "source": [
    "aws.events"
  ],
  "resources": [
    "${module.lambda.lambda_function_arn}"
  ]
}
EOF
}

resource "aws_cloudwatch_event_target" "cron_event_target" {
  rule      = aws_cloudwatch_event_rule.cron_eventbridge_rule.name
  target_id = "TargetFunctionV1"
  arn       = module.lambda.lambda_function_arn
}