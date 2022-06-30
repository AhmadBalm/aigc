resource "docker_network" "mynet" {
  name = "mynet"
}

data "docker_image" "myapp"{
    name = "stackupiss/northwind-app:v1"
}

resource "docker_container" "myapp"{
    name = "myapp"
    image = data.docker_image.myapp.id
    env = [
        "DB_HOST=${docker_container.mydb.ip_address}",
        "DB_USER=root",
        "DB_PASSWORD=changeit"
    ]
    networks_advanced{
        name = docker_network.mynet.name
    }
    ports{
        internal = 3000
        external = 8080
    }
}

data "docker_image" "mydb"{
    name = "stackupiss/northwind-db:v1"
}

resource "docker_container" "mydb"{
    name = "mydb"
    image = data.docker_image.mydb.id
    networks_advanced{
        name = docker_network.mynet.name
    }
    volumes{
        volume_name = docker_volume.mydb-volume.name
        container_path = "/var/lib/mysql"
    }
    ports{
        internal = 3000
        external = 3306
    }
}

resource "docker_volume" "mydb-volume" {
  name = "mydb-volume"
}