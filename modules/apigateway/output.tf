output "rest_api_id" {
  value = aws_api_gateway_rest_api.api_gateway.id
}
output "resource_id" {
  value = aws_api_gateway_resource.api_gateway_resource.id
}
output "resource_path" {
  value = aws_api_gateway_resource.api_gateway_resource.path
}
