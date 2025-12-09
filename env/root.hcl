  locals {
  region         = "us-east-1"
  jenkins_ami_id = "ami-0c5b6ddef5dedc1fd"
  jenkins_instance_type = "c7i-flex.large"
  jenkinsavailability_zone = "us-east-1a"
  jenkins_cidr       = "10.0.1.0/24"

  account_id = get_aws_account_id()
 
  state_bucket = "core5-tf-state-${local.account_id}"

  
  }

  remote_state {
  backend = "s3"
  config = {
    bucket = local.state_bucket
    key    = "${path_relative_to_include()}/terraform.tfstate"
    region = "us-east-1"
  }
  }