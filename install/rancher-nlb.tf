#
# AWS resources for Rancher NLB
#

resource "aws_eip" "rancher-nlb" {
  count = 2
}

resource "aws_alb" "rancher" {
  name               = "rancher-nlb"
  internal           = "false"
  load_balancer_type = "network"

  subnet_mapping {
    subnet_id        = "${var.subnets[0]}"
    allocation_id    = "${element(aws_eip.rancher-nlb.*.id, 0)}"
  }
  subnet_mapping {
    subnet_id        = "${var.subnets[1]}"
    allocation_id    = "${element(aws_eip.rancher-nlb.*.id, 1)}"
  }
  tags {
    Name              = "${var.env_name}-rancher-nlb"
  }

}

resource "aws_lb_listener" "rancher-80" {
  load_balancer_arn = "${aws_alb.rancher.arn}"
  port              = "80"
  protocol          = "TCP"

  default_action {
    target_group_arn = "${aws_alb_target_group.rancher-80.arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener" "rancher-443" {
  load_balancer_arn = "${aws_alb.rancher.arn}"
  port              = "443"
  protocol          = "TCP"

  default_action {
    target_group_arn = "${aws_alb_target_group.rancher-443.arn}"
    type             = "forward"
  }
}
