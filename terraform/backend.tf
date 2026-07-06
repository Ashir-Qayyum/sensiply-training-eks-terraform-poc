terraform {

  backend "s3" {


    bucket         = "sensiply-eks-tf-state-bucket"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "sensiply-terraform-lock"
    encrypt        = true
  }
}