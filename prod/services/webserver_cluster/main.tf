terraform {
  backend "s3" {
    bucket         = "mdv-terraform-state"
    key            = "test/prod/services/webserver-cluster/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tfstate_locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source = "github.com/mdv-devops/terraform-modules//services/webserver_cluster?ref=v0.0.1"

  db_remote_state_bucket = "mdv-terraform-state"
  db_remote_state_key    = "test/prod/data_stores/mysql/terraform.tfstate"
  region                 = "us-east-1"
}

resource "aws_autoscaling_schedule" "scale_up" {
  scheduled_action_name  = "scale_up_at _business_hours"
  min_size               = 2
  max_size               = 5
  desired_capacity       = 5
  recurrence             = "1 20 * * *"
  autoscaling_group_name = module.webserver_cluster.autoscaling_group_name
}

resource "aws_autoscaling_schedule" "scale_down" {
  scheduled_action_name  = "scale_down_at_night"
  min_size               = 2
  max_size               = 4
  desired_capacity       = 2
  recurrence             = "11 20 * * *"
  autoscaling_group_name = module.webserver_cluster.autoscaling_group_name
}
