module "api_gateway" {
  source              = "./apiWithLambda/apigateway"
  api_name            = "events"
  api_gateway_name    = "api_gateway"
}

module "api_gateway_get_method" {
  source              = "./apiWithLambda/apiMethod"
  http_method         = "GET"
  lambda_invoke_arn   = module.lambda_read_event.lambda_invoke_arn
  function_name       = module.lambda_read_event.function_name
}
module "api_gateway_post_method" {
  source              = "./apiWithLambda/apiMethod"
  http_method         = "POST"
  lambda_invoke_arn   = module.lambda_new_event.lambda_invoke_arn
  function_name       = module.lambda_new_event.function_name
}

module "basic_infrastructure" {
  source              = "./apiWithLambda/basicInfrastructure"
}

module "lambda_new_event" {
  source              = "./apiWithLambda/lambda"
  function_name       = "newEvent"
}

module "lambda_read_event" {
  source              = "./apiWithLambda/lambda"
  function_name       = "readEvent"
}

module "database" {
  source              = "./apiWithLambda/database"
  api_name              = "events"
}

module "api_gateway_deployment" {
  source              = "./apiWithLambda/deployAPIGateway"
  stage_name          = "prod"
}