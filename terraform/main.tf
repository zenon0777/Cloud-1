
terraform {
  required_version = ">= 1.0.0"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}


resource "digitalocean_ssh_key" "vagrant_ssh" {
  name       = "vagrant_ssh"
  public_key = file("/home/vagrant/.ssh/id_rsa.pub")
}

#Provider Block
provider "digitalocean" {
	token= var.do_token
}

#recouces Block
resource "digitalocean_droplet" "its-me" {
	image = "debian-12-x64"
	name = "its-me"
	region = "nyc3"
	size = "s-2vcpu-4gb-120gb-intel"
	ssh_keys = [digitalocean_ssh_key.vagrant_ssh.id]

	connection {
		type        = "ssh"
		user        = "root"
		private_key = file("/home/vagrant/.ssh/id_rsa")
		host        = self.ipv4_address
	}

	provisioner "remote-exec" {
		inline = [
			"mkdir -p /root/scripts"
		]
	}

	provisioner "file" {
		source      = "/home/vagrant/terraform/setup_inception.sh"
		destination = "/root/scripts/setup_inception.sh"
	}

	provisioner "file" {
		source      = "/home/vagrant/terraform/.env"
		destination = "/root/.env"
	}

	provisioner "remote-exec" {
		inline = [
			"chmod +x /root/scripts/setup_inception.sh",
			"/root/scripts/setup_inception.sh"
		]
	}
}