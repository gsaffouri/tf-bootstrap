#!/bin/bash -e

# Adds custom flag(s) to script
while getopts 'pfu' OPTION; do
  case "$OPTION" in
    # Use this option to execute 'terraform apply'
    p)
      argP="push"
      ;;
    # This option is only for the CI GitHub Actions pipeline
    f)
      argF="fmt"
      ;;
    u)
      argU="update"
      ;;
    ?)
      echo "Usage: $(basename $0) [-p] [-f] [-u]"
      exit 1
      ;;
  esac
done

# Removes temporary files
./cleanup-tf.sh

if [ -n "$argF" ]
then
  # Copies main.tf file using local backend
  cp resources/main-local-backend.tf main.tf
fi

# Executes 'terraform apply' if the '-p' flag is used
if [ -n "$argP" ]
then
  # Initialize and apply terraform
  terraform init
  terraform apply --auto-approve

  # Return remote state s3 bucket name from output
  BUCKET_NAME=$(terraform output -raw aws_s3_bucket)

  # Copies main.tf file using remote backend
  cp resources/main-remote-backend.tf main.tf

  # Update backend block with s3 bucket name
  sed -i "s/UPDATE_ME/$BUCKET_NAME/g" main.tf

  # Copies state data to the s3 bucket
  terraform init -force-copy
fi

# Prepares main.tf if the '-u' flag is used
if [ -n "$argU" ]
then
  # Return remote state s3 bucket name from output
  BUCKET_NAME=$(aws s3 ls | grep terraform-remote-state | cut -d " " -f 3)

  # Copies main.tf file using remote backend
  cp resources/main-remote-backend.tf main.tf

  # Update backend block with s3 bucket name
  sed -i "s/UPDATE_ME/$BUCKET_NAME/g" main.tf

  # Initialized Terraform
  terraform init
fi
