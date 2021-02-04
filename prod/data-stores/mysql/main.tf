terraform {
  backend "s3" {
    bucket         = "mdv-terraform-state"
    key            = "test/prod/data_stores/mysql/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tfstate_locks"
    encrypt        = true
  }
}
provider "aws" {
  region = "us-east-1"
}


module "prod_mysql_db" {
  source = "github.com/mdv-devops/terraform-modules//data-stores/mysql?ref=v0.0.1"

  environment = "prod"
}
