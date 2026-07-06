output "cluster_role_arn" {

  value = aws_iam_role.eks_cluster_role.arn
}

output "worker_role_arn" {
  value = aws_iam_role.worker_role.arn
}

output "cluster_policy_attachment" {
  value = aws_iam_role_policy_attachment.cluster_policy
}

output "worker_node_attachment" {
  value = aws_iam_role_policy_attachment.worker_node_policy
}

output "cni_attachment" {
  value = aws_iam_role_policy_attachment.cni_policy
}

output "ecr_attachment" {
  value = aws_iam_role_policy_attachment.ecr_readonly
}