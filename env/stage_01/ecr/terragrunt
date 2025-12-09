
include "root "{
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://github.com/Core5-team/iac_core.git//modules/ecr?ref=CORE5-14-change-tags-in-iac-core"
}



dependency "network" {
  config_path = "../network"
  mock_outputs = {
    vpc_id               = "vpc-xxxx"
    igw_id   = "igw-xxxx"
  }
}

inputs = {
  

  
}
