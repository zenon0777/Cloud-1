#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y curl 

cat /home/vagrant/.ssh/me.pub >> /home/vagrant/.ssh/authorized_keys
mkdir -p /root/.ssh

cat /home/vagrant/.ssh/me.pub >> /root/.ssh/authorized_keys

sudo apt-get install vim -y

sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
sudo apt-get install gnupg -y

wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

sudo apt-get install terraform -y

ssh-keygen -t rsa -b 4096 -f /home/vagrant/.ssh/id_rsa -N ""

sudo chmod 644 /home/vagrant/.ssh/id_rsa.pub
sudo chmod 644 /home/vagrant/.ssh/id_rsa

cd /home/vagrant/terraform

terraform init

terraform apply -auto-approve