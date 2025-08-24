data "aws_eks_cluster" "cluster" {
  name = local.cluster_name
}
