variable "project_name" {}
variable "vpc_id" {}
variable "subnet_1" {}
variable "subnet_2" {}
variable "db_name" {}
variable "db_username" {}
variable "db_password" {}

variable "instance_class" {
  default = "db.t3.micro"
}

variable "allocated_storage" {
  default = 20
}