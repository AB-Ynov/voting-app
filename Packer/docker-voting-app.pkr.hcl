packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source  = "github.com/hashicorp/docker"
    }
    ansible = {
      version = "~> 1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

source "docker" "ubuntu" {
  image  = "ubuntu:latest"
  commit = true
     changes = [
      "ENTRYPOINT [\"/usr/bin/python3\", \"/app/azure-vote/main.py\"]",
      "EXPOSE 80"
    ]
}

build {
  name = "build-voting-app"
  sources = [
    "source.docker.ubuntu"
  ]

  provisioner "ansible" {
    playbook_file = "../Ansible/playbook.yml"
    extra_arguments = [ "--scp-extra-args", "'-O'" ]
  }

  post-processors {
    post-processor "docker-tag" {
      repository = "joffreydupire/build-voting-app"
      tags = ["latest"]
    }

    post-processor "docker-push" {
      login = true
      login_username = "joffreydupire"
      login_password = "mettre_token_pat"
    }
  }
}