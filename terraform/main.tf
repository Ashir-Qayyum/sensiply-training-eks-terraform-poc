module "vpc" {

  source               = "./modules/vpc"
  project_name         = var.project_name
  region               = var.region
  vpc_cidr             = var.vpc_cidr
  public_subnet_1_cidr = var.public_subnet_1_cidr
  public_subnet_2_cidr = var.public_subnet_2_cidr

}

module "iam" {

  source       = "./modules/iam"
  project_name = var.project_name

}


module "eks" {

  source           = "./modules/eks"
  project_name     = var.project_name
  cluster_role_arn = module.iam.cluster_role_arn
  subnet_1         = module.vpc.public_subnet_1
  subnet_2         = module.vpc.public_subnet_2

}


module "nodegroup" {

  source = "./modules/nodegroup"

  project_name    = var.project_name
  cluster_name    = module.eks.cluster_name
  worker_role_arn = module.iam.worker_role_arn

  subnet_1 = module.vpc.public_subnet_1
  subnet_2 = module.vpc.public_subnet_2

  cluster_policy_dependency = module.iam.cluster_policy_attachment
  worker_policy_dependency  = module.iam.worker_node_attachment
  cni_policy_dependency     = module.iam.cni_attachment
  ecr_policy_dependency     = module.iam.ecr_attachment
}