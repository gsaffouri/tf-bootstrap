module "oidc-github" {
  source  = "unfunco/oidc-github/aws"
  version = "1.6.0"
  # insert the 1 required variable here
  github_repositories = [
    "gsaffouri/tf-bootstrap:ref:refs/heads/main",
  ]
  attach_admin_policy = true
}