
include {
  path = find_in_parent_folders("root.hcl")
}

dependency "jenkins" {
  config_path = "../jenkins"

  mock_outputs = {
    vpc_id        = "vpc-mock"
    igw_id        = "igw-mock"
    key_pair_name = "mock-key"
  }
}

remote_state {
  backend = "s3"
  config = {
    region       = "us-east-1"
    bucket       = "core5-tf-state-stage-01"
    key          = "stage-01/infrastructure/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}

inputs = {
  
  vpc_id        = dependency.jenkins.outputs.vpc_id
  igw_id        = dependency.jenkins.outputs.igw_id
  key_pair      = dependency.jenkins.outputs.key_pair_name
  
  enable_consul  = true
  enable_iam_ssm = true
  enable_lb = true
  enable_web = true
  enable_db = true
  enable_monitoring = true
  env = "stage_01"
  available_zone = "us-east-1a"
  birdwatching_dns_name = "birdwatching-app.pp.ua"
  birdwatching_ami_id = "ami-0ecb62995f68bb549"
  role_arn       = get_env("ROLE_ARN")
  
}
