terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

module "vpc" {
  source   = "../vpc"
  app_name = var.app_name
  cidr     = var.cidr
  priv_subnet_cidr  = var.priv_subnet_cidr
  pub_subnet_cidr   = var.pub_subnet_cidr
  availability_zone = var.availability_zone
}

module "rds" {
  source          = "../rds"
  aws_db_username = var.aws_db_username
  aws_db_password = var.aws_db_password
}

module "beanstalk" {
  source       = "../beanstalk"
  app_name     = var.app_name
  vpc_id       = module.vpc.vpc_id
  pv_subnet_id = module.vpc.pv_subnet_id
  pb_subnet_id = module.vpc.pb_subnet_id
}

module "ecs_fargate" {
  source      = "../ecs"
  app_name    = var.app_name
  domain_name = var.domain_name    
}
