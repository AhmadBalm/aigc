data "digitalocean_ssh_key" "ssh-key"{
    name = "GVT-MacBook"
}

resource "local_file" "ssh-key-file" {
    filename = "${data.digitalocean_ssh_key.ssh-key.name}.pub"
    content = data.digitalocean_ssh_key.ssh-key.public_key
    file_permission = "0644"
}

output "ssh-key-id"{
    value = data.digitalocean_ssh_key.ssh-key.name
}

# Create a new Web Droplet in the nyc2 region
resource "digitalocean_droplet" "web" {
  image  = "ubuntu-18-04-x64"
  name   = "web-1"
  region = "sgp1"
  size   = "s-1vcpu-2gb"
  ssh_keys = [ data.digitalocean_ssh_key.ssh-key.id ]
}

# generate inventory file for Ansible
resource "local_file" "inventory_yaml" {
  content = templatefile("${path.module}/templates/inventory.tpl",
    {
      host_ip = digitalocean_droplet.web.ipv4_address
      host_status = digitalocean_droplet.web.status
    }
  )
  filename = "inventory.yaml"
}