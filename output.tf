output "rest_api_id" {
  value = module.api_gateway.rest_api_id
}
output "resource_id" {
  value = module.api_gateway.resource_id
}
output "resource_path" {
  value = module.api_gateway.resource_path
}
output "get_http_method" {
  value = module.api_gateway_get_method.http_method
}
output "post_http_method" {
  value = module.api_gateway_post_method.http_method
}
output "iam_role" {
  value = module.basic_infrastructure.iam_role
}
output "lambda_new_event_name" {
  value =  module.lambda_new_event.function_name
}
output "lambda_read_event_name" {
  value =  module.lambda_read_event.function_name
}
output "lambda_new_event_arn" {
  value = module.lambda_new_event.lambda_invoke_arn
}
output "lambda_read_event_arn" {
  value = module.lambda_read_event.lambda_invoke_arn
}
output "invoke_url" {
  value = module.api_gateway_deployment.invoke_url
}



