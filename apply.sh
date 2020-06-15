terraform init

terraform apply --target=module.api_gateway -auto-approve
terraform apply --target=module.basic_infrastructure -auto-approve
terraform apply --target=module.database -auto-approve
terraform apply --target=module.lambda_new_event -auto-approve
terraform apply --target=module.lambda_read_event -auto-approve
terraform apply --target=module.api_gateway_get_method -auto-approve
terraform apply --target=module.api_gateway_post_method -auto-approve
terraform apply --target=module.api_gateway_deployment -auto-approve