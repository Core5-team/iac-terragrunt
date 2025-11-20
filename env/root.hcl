
locals {
  region         = "eu-central-1"
  module_source  = "github.com/The-A-Team-organization/iac_account_setup.git//modules?ref=main"
}


terraform {
  source = local.module_source
}


inputs = {
  aws_region   = local.region
  ami_id       = "ami-0a5b0d219e493191b"
}
