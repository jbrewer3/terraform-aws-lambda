variable "region" {
  description = "default region"
  type = string
  default = ""
}

variable "prefix-name" {
  description = "prefix to add to resources"
  type        = string
  default     = "ex"
}

variable "function_name" {
  description = "Name of lambda function"
  type        = string
  default     = ""
}

variable "function_description" {
  description = "Description of what the lambda function does"
  type        = string
  default     = ""
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

variable "timeout" {
  description = "Time before function times out in seconds"
  type        = number
  default     = 900
}

variable "signing_profile_name" {
  description = "Name for the signing profile"
  type        = string
  default     = "lambda_signing_profile"
}

variable "bucket_prefix" {
  description = "s3 bucket prefix"
  type        = string
  default     = "lambda"
}

variable "attach_policy_json" {
  description = "add policy to lambda function"
  type        = bool
  default     = false
}

variable "lambda_policy" {
  description = "JSON policy for IAM"
  type        = string
  default     = ""
}

variable "lambda_policy_name" {
  description = "JSON policy for IAM"
  type        = string
  default     = "lambda"
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


variable "policy_statements" {
  type = map(object({
    effect    = string
    actions   = list(string)
    resources = list(string)
    conditions = optional(map(string))
  }))
  default = {
    placeholder = {
      effect    = "Allow",
      actions   = [""],
      resources = [""]
    }
  }
}
