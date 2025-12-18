###########################################
# Data Sources - PC-IAC-011
###########################################

# Cluster EKS por nomenclatura estándar
data "aws_eks_cluster" "selected" {
  name = "${var.client}-${var.project}-${var.environment}-eks-main"
}

# IAM Roles para addons que requieren service account
data "aws_iam_role" "addon_roles" {
  for_each = toset([
    for cluster_key, cluster in var.addons_config : [
      for addon_key, addon in cluster.addons : addon_key
      if contains(["aws-ebs-csi-driver", "aws-efs-csi-driver"], addon_key)
    ]...
  ]...)
  
  name = "${var.client}-${var.project}-${var.environment}-role-eks-addon-${each.key}"
}
