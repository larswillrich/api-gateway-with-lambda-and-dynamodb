resource "aws_api_gateway_method" "api_gateway_method" {
  rest_api_id   = data.terraform_remote_state.api_gateway.outputs.rest_api_id
  resource_id   = data.terraform_remote_state.api_gateway.outputs.resource_id
  http_method   = var.http_method
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "api_gateway_method_response_200" {
    rest_api_id   = data.terraform_remote_state.api_gateway.outputs.rest_api_id
    resource_id   = data.terraform_remote_state.api_gateway.outputs.resource_id
    http_method   = aws_api_gateway_method.api_gateway_method.http_method
    status_code   = "200"
    response_parameters = {
        "method.response.header.Access-Control-Allow-Origin" = true
    }
    depends_on = [aws_api_gateway_method.api_gateway_method]
}

resource "aws_api_gateway_integration" "get_integration" {
  rest_api_id             = data.terraform_remote_state.api_gateway.outputs.rest_api_id
  resource_id             = data.terraform_remote_state.api_gateway.outputs.resource_id
  http_method             = aws_api_gateway_method.api_gateway_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn
}

resource "aws_lambda_permission" "lambda_permission_readEntry" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:eu-central-1:380702078761:${data.terraform_remote_state.api_gateway.outputs.rest_api_id}/*/${aws_api_gateway_method.api_gateway_method.http_method}${data.terraform_remote_state.api_gateway.outputs.resource_path}"
}


data "terraform_remote_state" "api_gateway" {
  backend = "local"

  config = {
    path = "./terraform.tfstate"
  }
}

data "terraform_remote_state" "lambda" {
  backend = "local"

  config = {
    path = "./terraform.tfstate"
  }
}