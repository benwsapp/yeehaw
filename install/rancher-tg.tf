#
# AWS resources for Rancher Target Group
#


resource "aws_alb_target_group" "rancher-80" {
  name     = "rancher-80"
  port     = 80
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"
  
  health_check {
    interval         = "10"
    path             = "/healthz"
    protocol         = "HTTP"
    port             = "80"
    matcher          = "200-399"
  }
}

resource "aws_alb_target_group" "rancher-443" {
  name     = "rancher-443"
  port     = 443
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    interval         = "10"
    path             = "/healthz"
    protocol         = "HTTP"
    port             = "80"
    matcher          = "200-399"
  }
}

resource "aws_alb_target_group_attachment" "rancher00-80" {
  target_group_arn = "${aws_alb_target_group.rancher-80.arn}"
  target_id        = "${element(aws_instance.rancher.*.id, 0)}"
  port             = 80
}

resource "aws_alb_target_group_attachment" "rancher01-80" {
  target_group_arn = "${aws_alb_target_group.rancher-80.arn}"
  target_id        = "${element(aws_instance.rancher.*.id, 1)}"
  port             = 80
}

resource "aws_alb_target_group_attachment" "rancher02-80" {
  target_group_arn = "${aws_alb_target_group.rancher-80.arn}"
  target_id        = "${element(aws_instance.rancher.*.id, 2)}"
  port             = 80
}

resource "aws_alb_target_group_attachment" "rancher00-443" {
  target_group_arn = "${aws_alb_target_group.rancher-443.arn}"
  target_id        = "${element(aws_instance.rancher.*.id, 0)}"
  port             = 443
}

resource "aws_alb_target_group_attachment" "rancher01-443" {
  target_group_arn = "${aws_alb_target_group.rancher-443.arn}"
  target_id        = "${element(aws_instance.rancher.*.id, 1)}"
  port             = 443
}

resource "aws_alb_target_group_attachment" "rancher02-443" {
  target_group_arn = "${aws_alb_target_group.rancher-443.arn}"
  target_id        = "${element(aws_instance.rancher.*.id, 2)}"
  port             = 443
}
