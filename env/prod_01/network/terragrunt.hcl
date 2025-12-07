include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://github.com/Core5-team/iac_account_setup.git//modules/vpc?ref=CORE5-13-fork-iac-core-repo-and-change-path"
}



inputs = {

}
