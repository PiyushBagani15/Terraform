provider "aws"  {
region  =  "ap-south-1"
profile = "default"
}

terraform {
  backend "s3" {
    bucket = "my-tf-hello-tf-test-bucket"
    key    = "my.tfstate"
    region = "ap-south-1"
    dynamodb_table = "tfstate-lock-table"
  }
}