terraform {
  backend "s3" {
    bucket         = "mdv-terraform-state"
    key            = "test/staging/services/webserver-cluster/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tfstate_locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source = "github.com/mdv-devops/terraform-modules//services/webserver_cluster"

  db_remote_state_bucket = "mdv-terraform-state"
  db_remote_state_key    = "test/staging/data_stores/mysql/terraform.tfstate"
  region                 = "us-east-1"
}
