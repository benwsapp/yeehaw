#
# Rancher AWS Security Group resources
#

resource "aws_security_group" "rancher-sg" {
  name        = "${var.env_name}-rancher-sg"
  description = "Rancher security group"
  vpc_id      = "${var.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.env_name}-rancher-sg"
  }
}

resource "aws_security_group_rule" "rancher-ingress-ssh" {
  description              = "Allow SSH inbound to Rancher"
  from_port                = 22
  protocol                 = "tcp"
  to_port                  = 22
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
  
  security_group_id        = "${aws_security_group.rancher-sg.id}"
}

resource "aws_security_group_rule" "rancher-ingress-http" {
  description              = "Allow HTTP inbound to Rancher"
  from_port                = 80
  protocol                 = "tcp"
  to_port                  = 80
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
  
  security_group_id        = "${aws_security_group.rancher-sg.id}"
}

resource "aws_security_group_rule" "rancher-ingress-https" {
  description              = "Allow HTTPS inbound to Rancher"
  from_port                = 443
  protocol                 = "tcp"
  to_port                  = 443
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
  
  security_group_id        = "${aws_security_group.rancher-sg.id}"
}

resource "aws_security_group_rule" "rancher-ingress-k8s-api" {
  description              = "Allow K8s API inbound to Rancher"
  from_port                = 6443
  protocol                 = "tcp"
  to_port                  = 6443
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
  
  security_group_id        = "${aws_security_group.rancher-sg.id}"
}

resource "aws_security_group_rule" "rancher-ingress-internal" {
  description                        = "Allow all inbound to Rancher nodes from Rancher security group"
  from_port                          = 0
  protocol                           = "-1"
  to_port                            = 65535
  type                               = "ingress"
  source_security_group_id           = "${aws_security_group.rancher-sg.id}"

  security_group_id        = "${aws_security_group.rancher-sg.id}"
}
