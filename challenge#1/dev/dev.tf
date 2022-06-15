terraform {
  backend "s3" {
    profile = "test-credentials"
    bucket  = "test-s3-terraform"
    region  = "us-east-1"
    key     = "main/terraform.tfstate"
    encrypt = "true"
    dynamodb_table = "test-terraform-state-lock"
  }
}

module "main" {
  source      = "../modules/main"
  region      = "us-east-1"
  aws_profile = "test-credentials"
  app_name    = "test-challenge"
  cidr        = "10.0.0.0/16"
  domain_name = "test.challenge.com"
  aws_db_username = "admin"
  aws_db_password = "admin@123"
  availability_zone = "us-east-1a"
  priv_subnet_cidr  = "10.0.1.0/24"
  pub_subnet_cidr   = "10.0.2.0/24"

}