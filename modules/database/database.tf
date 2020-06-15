resource "aws_dynamodb_table" "events" {
  name           = "events"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "event"

  attribute {
    name = "event"
    type = "S"
  }
}