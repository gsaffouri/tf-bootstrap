module "oidc-github" {
  source  = "unfunco/oidc-github/aws"
  version = "1.6.0"
  # insert the 1 required variable here
  github_repositories = [
    # "https://github.com/2ndLetter/amazon-eks",
    # "git@github.com:chadwickcloudservices/amazon-eks.git",
    "chadwickcloudservices/amazon-eks:ref:refs/heads/main",
    # "another-org/another-repo:ref:refs/heads/main",
  ]
}