
include {
  path = find_in_parent_folders("root.hcl")
}


remote_state {
  backend = "s3"
  config = {
    region       = "eu-central-1"
    bucket       = "team-a-tf-state-prod-1"
    key          = "prod/terraform.tfstate"
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
  env = "prod"
  available_zone = "eu-central-1c"
  birdwatching_dns_name = "birdwatching-app.pp.ua"
  birdwatching_ami_id = "ami-004e960cde33f9146"
  role_arn       = get_env("ROLE_ARN")
}
