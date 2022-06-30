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

    backend s3 {
        skip_credentials_validation = true
        skip_metadata_api_check = true
        skip_region_validation = true
        endpoint = "https://sgp1.digitaloceanspaces.com"
        region = "sgp1"
        bucket = "ahmadbucket"
        key = "apic/terraform.tfstate"
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