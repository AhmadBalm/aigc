variable token {
    type = string
}

variable code_server_snapshot_name {
    type = string
    default = "code-server"
}

variable DO_private_key {
  type = string
  sensitive = true
}
variable DO_image {
    type = string
    default = "ubuntu-20-04-x64"
}
variable DO_region {
    type = string
    default = "sgp1"
}
variable DO_size {
    type = string
    default = "s-1vcpu-1gb"
}

variable code_server {
  type = string
  default = "codeserverhost"
}
variable cs_domain_name {
  type = string
  default = "nip.io"
}
variable cs_password {
  type = string
}