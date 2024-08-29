provider "aws" {
  region = "us-east-1"

}
# terraform {
#   backend "s3" {
#     bucket = "public-tfpstate-cyberknights-bucket"
#     key    = "tfstate"
#     region = "us-east-1"
#   }
# }