resource "aws_eks_node_group" "worker_nodes" {

  cluster_name    = var.cluster_name
  node_group_name = "${var.project_name}-worker-group"
  node_role_arn   = var.worker_role_arn

  subnet_ids = [

    var.subnet_1,
    var.subnet_2

  ]


  instance_types = [
    "t3.small"
  ]


  scaling_config {

    desired_size = 1
    min_size     = 1
    max_size     = 1

  }


  capacity_type = "ON_DEMAND"

  ami_type = "AL2023_x86_64_STANDARD"

  force_update_version = true

  depends_on = [

    var.cluster_policy_dependency,
    var.worker_policy_dependency,
    var.cni_policy_dependency,
    var.ecr_policy_dependency
  ]


}