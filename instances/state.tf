

terraform {
  backend "s3" {
    bucket         = "stonize-terraform-state"
    key            = "stage/algorand-test/terraform.tfstate"
    region         = "eu-south-1"
    encrypt        = true
    # dynamodb_table = "my-lock-table"
  }
}
