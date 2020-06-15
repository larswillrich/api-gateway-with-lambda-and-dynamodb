resource "aws_api_gateway_deployment" "api_gateway_deployment" {
  rest_api_id = data.terraform_remote_state.api_gateway.outputs.rest_api_id
  stage_name  = var.stage_name
}

data "terraform_remote_state" "api_gateway" {
  backend = "local"

  config = {
    path = "./terraform.tfstate"
  }
}