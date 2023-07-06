variable "region" {
  description = "default region"
  type = string
  default = ""
}

variable "function_name" {
  description = "Name of lambda function"
  type        = string
  default     = "lambda_function"
}

variable "function_description" {
  description = "Description of what the lambda function does"
  type        = string
  default     = "function to change passwords"
}

variable "function_handler" {
  description = "Method in function code that processes events"
  type        = string
  default     = "lambda_function.lambda_handler"
}

variable "lambda_runtime" {
  description = "lambda function runtime (eg python3.8)"
  type        = string
  default     = "python3.9"
}


variable "source_file" {
  description = "File path where function resides"
  type        = string
  default     = ""
}

variable "output_path" {
  description = "Path of output zip file for function"
  type        = string
  default     = ""
}

# variable "policy_statements" {
#   type = map(object({
#     effect    = string
#     actions   = list(string)
#     resources = list(string)
#     conditions = optional(map(string))
#   }))
# }

