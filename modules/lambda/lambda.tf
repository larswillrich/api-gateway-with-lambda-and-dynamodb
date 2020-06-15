resource "aws_lambda_function" "function" {
  filename      = "./${var.function_name}/${var.function_name}.zip"
  function_name = var.function_name
  role          = data.terraform_remote_state.aws_iam_role.outputs.iam_role.arn
  handler       = "${var.function_name}.handle"
  timeout       = "3"

  source_code_hash = filebase64sha256("./${var.function_name}/${var.function_name}.zip")

  runtime = "python3.8"
}

resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 1
}

data "terraform_remote_state" "aws_iam_role" {
  backend = "local"

  config = {
    path = "./terraform.tfstate"
  }
}




