#
# Terraform null resource to pull IP addresses and private key information and create rancher-cluster.yml file
#

resource "null_resource" "configure-rancher-ips" {
  
  provisioner "local-exec" {
    command = "envsubst < nodes.yml > rancher-cluster.yml"
    environment {
      RANCHER00_PUBLIC  = "${element(aws_instance.rancher.*.public_ip, 0)}"
      RANCHER00_PRIVATE = "${element(aws_instance.rancher.*.private_ip, 0)}"
      RANCHER00_KEY     = "${element(aws_instance.rancher.*.key_name, 0)}"  
      RANCHER01_PUBLIC = "${element(aws_instance.rancher.*.public_ip, 1)}"
      RANCHER01_PRIVATE = "${element(aws_instance.rancher.*.private_ip, 1)}"
      RANCHER01_KEY     = "${element(aws_instance.rancher.*.key_name, 1)}"  
      RANCHER02_PUBLIC = "${element(aws_instance.rancher.*.public_ip, 2)}"
      RANCHER02_PRIVATE = "${element(aws_instance.rancher.*.private_ip, 2)}"
      RANCHER02_KEY     = "${element(aws_instance.rancher.*.key_name, 2)}"  
    }
  }
}
