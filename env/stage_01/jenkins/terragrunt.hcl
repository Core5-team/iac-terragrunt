
include "root" {
  path = find_in_parent_folders("root.hcl")
  expose = true
}

locals {
  env = split("/", path_relative_to_include())[0]
}

terraform {
  source = "git::https://github.com/Core5-team/iac_core.git//modules/jenkins?ref=main"
}



dependency "network" {
  config_path = "../network"
}

inputs = {
  
  region         = include.root.locals.region
  ami =             include.root.locals.jenkins_ami_id
  
  vpc_id            = dependency.network.outputs.vpc_id
  igw_id            = dependency.network.outputs.internet_gateway_id
  env               = local.env
  instance_type     = include.root.locals.jenkins_instance_type
  availability_zone = include.root.locals.jenkinsavailability_zone
  subnet_cidr       = include.root.locals.jenkins_cidr
  
}
