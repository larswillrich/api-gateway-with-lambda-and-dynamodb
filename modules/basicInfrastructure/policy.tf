
resource "aws_iam_role" "iam_role_for_lambda_access_to_dynamodb" {
  name = "iam_role_for_lambda_access_to_dynamodb"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_role_for_lambda_access_to_dynamodb.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "lambda_access_dynamodb" {
  name        = "lambda_access_dynamodb"
  description = "lambda_access_dynamodb"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Action": [
            "dynamodb:BatchGetItem",
            "dynamodb:GetItem",
            "dynamodb:Query",
            "dynamodb:Scan",
            "dynamodb:BatchWriteItem",
            "dynamodb:PutItem",
            "dynamodb:UpdateItem"
        ],
      "Resource": "arn:aws:dynamodb:eu-central-1:380702078761:table/events",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_access_dynamodb_attachement" {
  role       = aws_iam_role.iam_role_for_lambda_access_to_dynamodb.name
  policy_arn = aws_iam_policy.lambda_access_dynamodb.arn
}


