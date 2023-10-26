### EKS_NODE_GROUP_IAM

data "aws_iam_policy_document" "assume_eks_node_group_role" {
  statement {
    effect = "Allow"

    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "eks_node_group_role" {
  name = "${var.eks_node_group_role_name}-${terraform.workspace}"
  assume_role_policy = data.aws_iam_policy_document.assume_eks_node_group_role.json
}

resource "aws_iam_role_policy_attachment" "attach_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role = aws_iam_role.eks_node_group_role.name
}

resource "aws_iam_role_policy_attachment" "attach_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role = aws_iam_role.eks_node_group_role.name
}

resource "aws_iam_role_policy_attachment" "attach_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role = aws_iam_role.eks_node_group_role.name
}