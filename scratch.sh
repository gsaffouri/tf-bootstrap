cp resources/main-local-backend.tf main.tf
terraform init
terraform apply -auto-approve
export BUCKET_NAME=$(terraform output -raw aws_s3_bucket)
cp resources/main-remote-backend.tf main.tf
sed -i "s/UPDATE_ME/$BUCKET_NAME/g" main.tf
terraform init -force-copy

./cleanup-tf.sh

export BUCKET_NAME=$(aws s3 ls | grep terraform-remote-state | cut -d " " -f 3)
cp resources/main-remote-backend.tf main.tf
terraform init
terraform state pull > terraform.tfstate

cp resources/main-local-backend.tf main.tf
terraform init -migrate-state

export BUCKET_NAME=$(aws s3 ls | grep terraform-remote-state | cut -d " " -f 3)
aws s3api delete-objects --bucket "$BUCKET_NAME" --delete "$(aws s3api list-object-versions --bucket ${BUCKET_NAME} --output=json --query='{Objects: Versions[].{Key:Key,VersionId:VersionId}}')"

terraform destroy -auto-approve