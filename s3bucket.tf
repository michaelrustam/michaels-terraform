
# # resource "aws_s3_bucket" "terraform_state" {
# #   bucket = "public-tfpstate-cyberknights-bucket" # Replace with your desired bucket name

# #   # Enable versioning for the bucket
# #   versioning {
# #     enabled = true
# #   }

#   # Enable server-side encryption for all objects in the bucket
#   #   server_side_encryption_configuration {
#   #     rule {
#   #       apply_server_side_encryption_by_default {
#   #         sse_algorithm = "AES256"
#   #       }
#   #     }
#   #   }

#   # Optionally, block public access to the bucket
#   #block_public_acls   = true
#   #block_public_policy = true
# }

# # Optional: Create a DynamoDB table for state locking
# resource "aws_dynamodb_table" "terraform_lock" {
#   name         = "terraform-lock-table"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }

#   tags = {
#     Name = "Terraform State Lock"
#   }
# }

# output "s3_bucket_name" {
#   value = aws_s3_bucket.terraform_state.bucket
# }

# output "dynamodb_table_name" {
#   value = aws_dynamodb_table.terraform_lock.name
# }
