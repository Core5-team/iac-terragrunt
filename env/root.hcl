
locals {
  region         = "us-east-1"
  module_source  = "github.com/Core5-team/iac_account_setup//modules?ref=CORE5-13-fork-iac-core-repo-and-change-path"
}


terraform {
  source = local.module_source
}


inputs = {
  aws_region   = local.region
  ami_id       = "ami-0fa3fe0fa7920f68e"
}
