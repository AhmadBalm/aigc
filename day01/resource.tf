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

data "docker_image" "dov-bear"{
    name = "chukmunnlee/dov-bear:v2"
}

output "dov-bear-md5"{
    value = data.docker_image.dov-bear.repo_digest
}

resource "docker_container" "dov-bear-container"{
    name = "dov-bear-${count.index}"
    count = length(var.ports)
    image = data.docker_image.dov-bear.id
    env = [
        "INSTANCE_NAME=myapp-${count.index}",
        "INSTANCE_HASH=${count.index}"
    ]
    ports{
        internal = 3000
        external = var.ports[count.index]
    }
}

output containter-names{
    value = [for c in docker_container.dov-bear-container: c.name]
}