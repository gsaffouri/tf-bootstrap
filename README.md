# tf-bootstrap

[![Linting](https://github.com/chadwickcloudservices/tf-bootstrap/actions/workflows/linting.yml/badge.svg)](https://github.com/chadwickcloudservices/tf-bootstrap/actions/workflows/linting.yml)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-purple.svg)](https://opensource.org/licenses/Apache-2.0)

Prepares an AWS account for Terraform remote state management and GitHub Actions OpenID Connect

### Assumptions

- You have the proper permissions to deploy the referenced resources in your AWS account
- You have the version of Terraform and AWS CLI referenced in the [Requirements](https://github.com/chadwickcloudservices/tf-bootstrap#requirements) section

### Usage

1. "Create a new fork" of this repository
   1. NOTE: If you don't want to enable the scheduled workflow, ignore steps 2-6
2. Within your forked repo, navigate to the "Actions" settings
3. Select "I understand my workflows, go ahead and enable them"
4. Select the "Linting" workflow on the left pane
5. Select "Enable workflow"
6. Select "Run workflow" > "Run workflow"
   1. This will execute the "Linting" pipeline
7. Remaining steps will occur within your local development environment
8. [Establish AWS CLI authentication]
9.  Clone your forked version of this repository and navigate to the root
10. Update line 6 in oidc.tf to match the "GitHub Org / Repository" of your forked version
11. Deploy resources by executing the deploy-tf.sh script with the '-p' flag
```bash
./deploy-tf.sh -p

# After the s3 bucket is created, the local state file will be moved to the s3 bucket
```
12. The AWS account is now ready to properly store Terraform state files
13. You can return the AWS S3 bucket name using either of the below commands
```bash
# aws cli
aws s3 ls | grep terraform-remote-state | cut -d " " -f 3

or

# terraform cli
terraform output -raw aws_s3_bucket
```
14. deploy-tf.sh (extended functionality for informational purposes)
```bash
# 'p' flag is used to deploy resources to an aws account using GitHub Actions
./deploy-tf.sh -p

# 'f' flag is exclusively used by GitHub Actions to execute scheduled linting
./deploy-tf.sh -f

# 'u' flag is used to prepare the main.tf file for existing deployments
./deploy-tf.sh -u

# 'd' flag is used to destroy all resources
./deploy-tf.sh -u
```

### Example Output

![alt text](resources/tf-bootstrap.png)

### Requirements

| Name                                                                                     | Version  |
| -----------------------------------------------------------------------------------------|----------|
| [aws provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)        | ~> 5.20  |
| [terraform](https://developer.hashicorp.com/terraform/downloads)                         | ~> 1.5.7 |
| [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) | ~> 2.7   |

### Resources

| Name                                                                                                                                                 | Type        |
| ---------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_dynamodb_table.backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table)                             | resource    |
| [aws_s3_bucket.backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)                                       | resource    |
| [aws_s3_bucket_acl.backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl)                               | resource    |
| [aws_s3_bucket_ownership_controls.backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource    |
| [aws_s3_bucket_versioning.backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning)                 | resource    |
| [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id)                                                  | resource    |

### External Modules

| Name | Version |
| ------------------------------------------------------------------------------------|-------|
| [oidc-github](https://registry.terraform.io/modules/unfunco/oidc-github/aws/latest) | 1.6.0 |

### References

 - [Terraform Backend S3]
 - [GitHub Actions]

### License

© 2023 [Brian Chadwick](https://github.com/chadwickcloudservices)
Made available under the terms of the [Apache License 2.0].

[terraform backend s3]: https://developer.hashicorp.com/terraform/language/v1.5.x/settings/backends/s3
[github actions]: https://docs.github.com/en/actions/quickstart
[Establish AWS CLI authentication]: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-authentication.html