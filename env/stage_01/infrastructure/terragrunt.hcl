include "root"{
  path = find_in_parent_folders("root.hcl")
}

locals {
  env = split("/", path_relative_to_include())[0]
}


terraform {
  source = "github.com/Core5-team/iac_account_setup//modules?ref=CORE5-13-fork-iac-core-repo-and-change-path"
}



dependency "network" {
  config_path = "../network"
  mock_outputs = {
    vpc_id               = "vpc-xxxx"
    igw_id   = "igw-xxxx"
  }
}


inputs = {
  
  enable_jenkins = false   
  create_vpc     = false

  vpc_id        = dependency.network.outputs.vpc_id
  igw_id        = dependency.network.outputs.internet_gateway_id
  nat_id        = dependency.network.outputs.aws_nat_gateway_id  
  public_rt_id  = dependency.network.outputs.public_route_table_id
  
  enable_consul  = true
  enable_iam_ssm = true
  enable_lb = true
  enable_web = true
  enable_db = true
  enable_monitoring = true
  env = local.env
  available_zone = "us-east-1a"
  birdwatching_dns_name = "birdwatching-app.pp.ua"
  birdwatching_ami_id = "ami-0ecb62995f68bb549"
  #role_arn       = get_env("ROLE_ARN")
  role_arn           = "arn:aws:iam::177362731942:role/TerraformRoleStage"
  
}
