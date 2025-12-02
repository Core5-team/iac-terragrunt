"" This repository contains the Terragrunt configuration used to deploy cloud infrastructure across multiple environments (dev, stage, prod) using the account-setup Terraform modules.

The project supports two provisioning modes:

## Mode A – Deploy infrastructure inside an existing VPC (Stage)

Used when Jenkins creates the VPC first, and the rest of the infrastructure must reuse it.

## Mode B – Full standalone provisioning (Dev/Prod)

The environment creates its own VPC without Jenkins.

This behavior is controlled through Terragrunt inputs using create_vpc and Terragrunt dependency.

## Repository Structure

```
iac-terragrunt/
│
├── root.hcl
│
└── env/
    ├── dev_01/
    │   └── infrastructure/
    ├── stage_01/
    │   ├── jenkins/
    │   └── infrastructure/
    └── prod_01/
        └── infrastructure/
```

## Root module

root.hcl defines:

AWS region

Shared Terraform source (iac_account_setup)

Global inputs like aws_region and base AMI

All environment configs inherit from it.

## Stage Environment Logic

1. stage_01/jenkins/

Jenkins is deployed first.
It creates:

VPC

Internet Gateway

Key Pair

## stage_01/infrastructure/

Infrastructure depends on Jenkins state:

```
dependency "jenkins" {
  config_path = "../jenkins"
}
```

## Prod / Dev Environment Logic

These environments do not include Jenkins logic and instead create their own VPC:

```
create_vpc = true
enable_jenkins = false
```

### How to Deploy

1. Deploy Jenkins (stage only)

Run locally

```
cd env/stage_01/jenkins
terragrunt init --backend-bootstrap
terragrunt apply
```

2. Deploy infrastructure (all environments)

Configure and run jenkins pipelines with parameters from jenkins ui
