resource "aws_api_gateway_rest_api" "api_gateway" {
  name        = var.api_gateway_name
  description = var.api_gateway_name
}

resource "aws_api_gateway_resource" "api_gateway_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = var.api_name
}

resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  name              = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.api_gateway.id}"
  retention_in_days = 1
}

resource "aws_api_gateway_method" "options_method" {
    rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
    resource_id   = aws_api_gateway_resource.api_gateway_resource.id
    http_method   = "OPTIONS"
    authorization = "NONE"
}
resource "aws_api_gateway_method_response" "options_200" {
    rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
    resource_id   = aws_api_gateway_resource.api_gateway_resource.id
    http_method   = aws_api_gateway_method.options_method.http_method
    status_code   = "200"
    response_models = {
         "application/json" = "Empty"
    }
    response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = true,
        "method.response.header.Access-Control-Allow-Methods" = true,
        "method.response.header.Access-Control-Allow-Origin" = true
    }
    depends_on = [aws_api_gateway_method.options_method]
}
resource "aws_api_gateway_integration" "options_integration" {
    rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
    resource_id   = aws_api_gateway_resource.api_gateway_resource.id
    http_method   = aws_api_gateway_method.options_method.http_method
    type          = "MOCK"
    depends_on = [aws_api_gateway_method.options_method]
}
resource "aws_api_gateway_integration_response" "options_integration_response" {
    rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
    resource_id   = aws_api_gateway_resource.api_gateway_resource.id
    http_method   = aws_api_gateway_method.options_method.http_method
    status_code   = aws_api_gateway_method_response.options_200.status_code
    response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
        "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
        "method.response.header.Access-Control-Allow-Origin" = "'*'"
    }
    depends_on = [aws_api_gateway_method_response.options_200]
}