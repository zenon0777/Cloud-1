# outputs.tf

# Output the Droplet's IP address
output "droplet_ip" {
  value = digitalocean_droplet.its-me.ipv4_address
  description = "The public IP address of the web server"
}

# Output the Droplet's status
output "droplet_status" {
  value = digitalocean_droplet.its-me.status
  description = "The status of the Droplet"
}
