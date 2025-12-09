include "root"{
  path = find_in_parent_folders("root.hcl")
  expose = true
}

locals {
  env = split("/", path_relative_to_include())[0]
}
terraform {
  source = "git::https://github.com/Core5-team/illuminati_eks.git?ref=CORE5-18--test-for-jenkins"
}


dependency "network" {
  config_path = "../network"

}


inputs = {
  

vpc_id                = dependency.network.outputs.vpc_id

region                = include.root.locals.region

#--------------------------------------------------------- Availability Zones

cluster_availability_zone_1 = "us-east-1a"
cluster_availability_zone_2 = "us-east-1b"
private_subnet_cidr_block_1 = "10.0.10.0/24" 
private_subnet_cidr_block_2 = "10.0.11.0/24"
public_subnet_cidr_block_1  = "10.0.12.0/24"
public_subnet_cidr_block_2  = "10.0.13.0/24"

#--------------------------------------------------------- Node Group Autoscaling Config

min_size     = 2
max_size     = 5
desired_size = 2

#--------------------------------------------------------- Cluster Configuration Variables

eks_cluster_name        = "illuminati_app_cluster" # Like illuminati_app_cluster
environment_name        = local.env # Like dev, stage or prod
eks_cluster_k8s_version = "1.34"

#--------------------------------------------------------- Nodes Configuration Variables

node_instance_types = ["c7i-flex.large"]

#--------------------------------------------------------- Workflow Setup


public_route_table_id = dependency.network.outputs.public_route_table_id # Like rtb-xxxxxxxxxxxxxxxxx
existing_nat_gateway_id = dependency.network.outputs.aws_nat_gateway_id # Like nat-xxxxxxxxxxxxxxxxx
domain_name           = "illuminati-core5-stage-02.pp.ua" # Like example.com

#--------------------------------------------------------- Database Setup

db_username         = get_env("DB_USER") # The username should be between 1 and 16 characters.
db_password         = get_env("DB_PASS") # The password should consist of at least 8 characters.

db_private_subnet_1 = "10.0.14.0/24" 
db_private_subnet_2 = "10.0.15.0/24"




  
  

  role_arn       = get_env("ROLE_ARN")
  # role_arn           = "arn:aws:iam::177362731942:role/TerraformRoleStage"
  
}
