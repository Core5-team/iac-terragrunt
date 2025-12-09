# Terragrunt Deployment Flow

Overview

All Terragrunt logic is centralized in the top-level root.hcl, which:

Creates an S3 backend bucket for Terraform state in the target AWS account

Generates state keys based on the folder path

Allows usage of logically independent modules, such as:

```
network / jenkins / infrastructure / eks
```

Each module manages its own state but follows a unified backend and configuration approach.

## Stage Account – Deployment Order

### 1. Prerequisites

Before starting:

Configure AWS CLI

Create and configure an AWS profile for the stage account

Clone the Terragrunt repository

### 2. Network Deployment

Navigate to the network module:

```
env/stage_01/network
```

Initialize the backend (this step creates the S3 state bucket):

```
terragrunt init --backend-bootstrap
```

Apply the configuration:

```
terragrunt apply
```

### 3. Jenkins Deployment

Navigate to the Jenkins module:

```
env/stage_01/jenkins
```

Run the same steps:

```
terragrunt init --backend-bootstrap
terragrunt apply
```

### 4. Further Deployments via Jenkins

Once Jenkins is configured and running:

All subsequent deployments (infrastructure, eks, etc.)

Should be executed via Jenkins pipelines, not manually

This ensures consistent role assumption and controlled access.

## Local Deployment (Without Jenkins)

If infrastructure needs to be deployed locally instead of via Jenkins:

Create an IAM role in the AWS account with the required permissions

In the infrastructure Terragrunt configuration:

Comment out the line using:

```
get_env("ROLE_ARN")
```

Uncomment the configuration with a hardcoded role_arn

This allows Terragrunt to use the locally configured AWS profile instead of Jenkins role assumption.

Notes

Backend bootstrap (--backend-bootstrap) is required only once per account

Each module remains independent but shares the same global backend logic

Jenkins is the preferred execution environment after initial bootstrap
