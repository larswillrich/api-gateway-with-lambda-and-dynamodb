variable "http_method" {
  type        = string
  description = "GET, PUT etc?"
}
variable "lambda_invoke_arn" {
  type        = string
  description = "lambda_invoke_arn"
}
variable "function_name" {
  type        = string
  description = "lambda function name"
}
