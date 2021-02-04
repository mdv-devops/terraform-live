terraform {
  backend "s3" {
    bucket         = "mdv-terraform-state"
    key            = "test/staging/data_stores/mysql/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tfstate_locks"
    encrypt        = true
  }
}
provider "aws" {
  region = "us-east-1"
}

module "staging_mysql_db" {
  source = "github.com/mdv-devops/terraform-modules//data-stores/mysql"

  environment = "staging"
}
