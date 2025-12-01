
include {
  path = find_in_parent_folders("root.hcl")
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
