#
# Default Rancher stack variables
#

### Application stack environment level ###
variable "env_name" {
  default = "dev"
}

### Instance type ###
variable "instance_type" {
  default = "c5.large"
}

### Instance count ###
variable "node_count" {
  default = 3
}

### Default Private Key ###
variable "priv_key" {
  default = "development"
}

### AWS Access/Secret Key Profile ###
variable "profile" {
  default = "development"
}

### AWS Region ###
variable "region" {
  default = "us-east-1"
}

### Hosted Route53 Zone ID ###
variable "route53_id" {
  default = "XXXYYYZZZ"
}

### Default subnet list ###
variable "subnets" {
  description = "Rancher VPC in US-East-1 subnets"
  type = "list"
  default = ["subnet-idnumber01", "subnet-idnumber02"]
}

### Default VPC ###
variable "vpc_id" {
  default = "vpc-idnumber"
}
