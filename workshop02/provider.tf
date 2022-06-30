terraform {
    required_providers {
        digitalocean = {
            source = "digitalocean/digitalocean"
            version = "2.21.0"
        }
        hashicorp = {
            source = "hashicorp/local"
            version = "2.2.3"
        }
        docker = {
            source = "kreuzwerker/docker"
            version = "2.17.0"
        }
    }
}

provider "docker" {
    host = "unix:///var/run/docker.sock"
}

provider "hashicorp" {
}

provider "digitalocean"{
    token = var.token
}