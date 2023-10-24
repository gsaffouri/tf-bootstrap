# tf-bootstrap

[![CI](https://github.com/chadwickcloudservices/tf-bootstrap/actions/workflows/terraform.yml/badge.svg)](https://github.com/chadwickcloudservices/tf-bootstrap/actions/workflows/terraform.yml)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-purple.svg)](https://opensource.org/licenses/Apache-2.0)

Prepares an AWS account for Terraform remote state management and GitHub Actions

### Requirements

- [AWS Provider] ~> 5.20
- [TLS Provider] ~> 3.0
- [Terraform] ~> 1.5.0
- [AWS CLI] ~> 2.7

### Assumptions

- You're running this from a *nix Operating System
- You have the proper permissions to deploy the referenced resources in your AWS account
- You have the above mentioned version of Terraform and AWS CLI installed

### Installation and usage
1. [Establish AWS CLI authentication]
2. Run deploy-tf.sh script
3. Refer to amazon-eks 

## Resources

| Name                                                                                                                                                 | Type        |
| ---------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_dynamodb_table.backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table)                             | resource    |
| [aws_s3_bucket.backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)                                       | resource    |
| [aws_s3_bucket_acl.backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl)                               | resource    |
| [aws_s3_bucket_ownership_controls.backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource    |
| [aws_s3_bucket_versioning.backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning)                 | resource    |
| [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id)                                                  | resource    |

## External Modules

| Name | Version |
| ------------------------------------------------------------------------------------|-------|
| [oidc-github](https://registry.terraform.io/modules/unfunco/oidc-github/aws/latest) | 1.6.0 |

## References

 - [Terraform Backend S3]
 - [GitHub Actions]

## License

© 2023 [Brian Chadwick](https://github.com/chadwickcloudservices)
Made available under the terms of the [Apache License 2.0].

[github actions]: https://docs.github.com/en/actions/quickstart
[terraform backend s3]: https://developer.hashicorp.com/terraform/language/v1.5.x/settings/backends/s3
[aws provider]: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
[terraform]: https://www.terraform.io
[tls provider]: https://registry.terraform.io/providers/hashicorp/tls/latest/docs
[aws cli]: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html
[Establish AWS CLI authentication]: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-authentication.html