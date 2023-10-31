#data "aws_iam_policy_document" "access_eks" {
#  statement {
#    effect = "Allow"
#    actions = [ "eks:ListFargateProfiles",
#                "eks:DescribeNodegroup",
#                "eks:ListNodegroups",
#                "eks:ListUpdates",
#                "eks:AccessKubernetesApi",
#                "eks:ListAddons",
#                "eks:DescribeCluster",
#                "eks:DescribeAddonVersions",
#                "eks:ListClusters",
#                "eks:ListIdentityProviderConfigs",
#                "iam:ListRoles"]
#    resources = ["arn:aws:ssm:*:410040632229:parameter/*"]
#  }
#}
#
#resource "aws_iam_role" "eks_aws_console_access" {
#  name = var.eks_aws_console_access
#  assume_role_policy = data.aws_iam_policy_document.access_eks.json
#}