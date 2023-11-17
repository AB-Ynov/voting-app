packer {
  required_plugins {
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
    docker = {
      source  = "github.com/hashicorp/docker"
      version = "~> 1"
    }
  }
}

source "docker" "autogenerated_1" {
  commit   = true
  image    = "ubuntu:latest"
  ssh_port = 22
  ssh_pty  = true
}

build {
  sources = ["source.docker.autogenerated_1"]

  provisioner "ansible" {
    ansible_connection = "local"
    playbook_file      = "/opt/voting-app/deploy.yml"
  }

}