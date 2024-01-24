variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
  default = "a03-bucket"
}

variable "dynamodb_name" {
    description = "DynamoDB table name"
    type        = string
    default = "a03-table"
}

data "aws_region" "aws_current_region" {}