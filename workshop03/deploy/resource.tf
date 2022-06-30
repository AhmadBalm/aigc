data "digitalocean_ssh_key" "ssh-key"{
    name = "GVT-MacBook"
}

output "ssh-key-id"{
    value = data.digitalocean_ssh_key.ssh-key.name
}

data "digitalocean_image" "code-server-snapshot" {
  name = var.code_server_snapshot_name
}

# Create a new Web Droplet
resource "digitalocean_droplet" "code-server" {
  image  = data.digitalocean_image.code-server-snapshot.id
  name   = var.code_server
  region = var.DO_region
  size   = var.DO_size
  ssh_keys = [ data.digitalocean_ssh_key.ssh-key.id ]
}

# generate inventory file for Ansible
resource local_file inventory_yaml {
  content = templatefile("inventory.yaml.tpl", 
    {
      ssh_private_key = var.DO_private_key
      codeserver = var.code_server
      droplet_ip = digitalocean_droplet.code-server.ipv4_address
      codeserver_domain = "${var.code_server}-${digitalocean_droplet.code-server.ipv4_address}.${var.cs_domain_name}"
      codeserver_password = var.cs_password
    }
  )
  filename = "inventory.yaml"
  file_permission = "0444"
}

resource local_file root_at_nginx {
  content = ""
  filename = "root@${digitalocean_droplet.code-server.ipv4_address}"
}

output nginx_ip {
  value = digitalocean_droplet.code-server.ipv4_address
}

output code_server_domain {
  value = "${var.code_server}-${digitalocean_droplet.code-server.ipv4_address}.${var.cs_domain_name}"
}