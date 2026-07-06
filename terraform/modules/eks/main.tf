resource "aws_eks_cluster" "eks_cluster" {

  name     = "${var.project_name}-cluster"
  role_arn = var.cluster_role_arn
  version  = "1.33"

  enabled_cluster_log_types = [ #Added after trivy scan result to enabling logging

    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"

  ]

  vpc_config {

    subnet_ids = [

      var.subnet_1,
      var.subnet_2
    ]

    endpoint_private_access = false
    endpoint_public_access  = true

    public_access_cidrs = [ # Adding after trivy scan resilt, to allow only my mac ip to access the api server

      "0.0.0.0/0"

    ]

  }

  depends_on = [

    var.cluster_role_arn
  ]
}