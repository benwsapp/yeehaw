#
# AWS resources for the Rancher LB DNS Record
#

resource "aws_route53_record" "rancher" {
  zone_id = "${var.route53_id}"
  name    = "rancher"
  type    = "A"

  alias {
    name                   = "${aws_alb.rancher.dns_name}"
    zone_id                = "${aws_alb.rancher.zone_id}"
    evaluate_target_health = true
  }
}
