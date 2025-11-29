
include {
  path = find_in_parent_folders("root.hcl")
}


remote_state {
  backend = "s3"
  config = {
    region       = "us-east-1"
    bucket       = "core5-tf-state-stage-01"
    key          = "stage-01/jenkins/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}


inputs = {
  enable_jenkins     = true
  jenkins_role_name  = "jenkins_role_stage"
  role_arn           = "arn:aws:iam::235194330448:role/TerraformRoleStage"
}
