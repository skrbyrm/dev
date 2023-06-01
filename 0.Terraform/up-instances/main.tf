terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("../.env/credentials.json")
  project     = "data-387913"
  region      = "us-central1"
  zone        = "us-central1-a"
}

variable "create_machine" {
  description = "Number of machines to create"
  type        = number
  default     = 1
}

resource "google_compute_instance" "additional_nodes" {
  count        = var.create_machine
  name         = "node-${count.index + 1}"
  machine_type = "t2a-standard-2"

  boot_disk {
    initialize_params {
      image = "ubuntu-2304-lunar-arm64-v20230502"
      size  = 50
      type  = "pd-ssd"
    }
  }

  metadata = {
    ssh-keys = file("../.env/pub")
    block-project-ssh-keys = "false"
  }

  metadata_startup_script = file("../startup-script.sh")

  network_interface {
    network = "default"

    access_config {
    }
  }

  tags = ["arm-node-firewall"]

  provisioner "local-exec" {
    command = "sudo echo '${self.network_interface[0].access_config[0].nat_ip} ${self.name}' >> /etc/hosts"
  }
}
