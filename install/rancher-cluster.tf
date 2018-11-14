#
# AWS resources for Rancher cluster nodes
#

### AWS AMIs ###

data "aws_ami" "ubuntu_xenial" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

### Docker Install Userdata ###

data "template_file" "rancher_userdata" {
  template = "${file("${path.module}/userdata.tpl")}"
}

### Rancher K8s Nodes ###

resource "aws_instance" "rancher" {
  count                  = "${var.node_count}"
  ami                    = "${data.aws_ami.ubuntu_xenial.id}"
  key_name               = "${var.priv_key}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${element(var.subnets, count.index)}"
  user_data              = "${data.template_file.rancher_userdata.rendered}"
  vpc_security_group_ids = ["${aws_security_group.rancher-sg.id}"]
  associate_public_ip_address = "true"

  tags {
    Name        = "rancher0${count.index}"
    Environment = "${var.env_name}"
  }
}
