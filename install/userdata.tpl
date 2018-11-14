#!/bin/bash -xe
apt-get update
apt-get install libltdl7
wget https://download.docker.com/linux/ubuntu/dists/xenial/pool/stable/amd64/docker-ce_17.03.3~ce-0~ubuntu-xenial_amd64.deb
dpkg -i docker-ce_17.03.3~ce-0~ubuntu-xenial_amd64.deb
usermod -aG docker ubuntu
