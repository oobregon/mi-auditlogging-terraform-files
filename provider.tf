# Authenticate terraform with aws account
# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"
  profile = "oscararq"
}

terraform {
  backend "s3" {
    bucket = "mi-auditlogging-s3-tf-state"
    key = "terraform.tfstate.dev"
    region = "us-west-2"
  }
}