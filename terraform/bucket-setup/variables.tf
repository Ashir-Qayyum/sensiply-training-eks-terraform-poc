variable "bucket_name" {

  default = "sensiply-eks-tf-state-bucket"
}

variable "dynamodb_table_name" {

  default = "sensiply-terraform-lock"
}