
include "root" {
  path = find_in_parent_folders("root.hcl")
  expose = true
}

locals {
  env = split("/", path_relative_to_include())[0]
}

terraform {
  source      = "https://github.com/Core5-team/iac_birdwatching.git//modules/mcp?ref=CORE5-40-MCP-instance"
  }



dependency "network" {
  config_path = "../network"
}

inputs = {
  
  region         = include.root.locals.region
  ami =             "ami-0ecb62995f68bb549"
  
  vpc_id            = dependency.network.outputs.vpc_id
  igw_id            = dependency.network.outputs.internet_gateway_id
  env               = local.env
  instance_type     = "t3.micro"
  availability_zone = include.root.locals.jenkinsavailability_zone
  mcp_subnet_cidr       = "10.0.20.0/24"
  
    
  nat_gateway_id       = dependency.network.outputs.aws_nat_gateway_id


}