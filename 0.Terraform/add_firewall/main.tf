terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("../credentials.json")
  project     = "data-387913"
  region      = "us-central1"
  zone        = "us-central1-a"
}

resource "google_compute_firewall" "arm-node-firewall" {
  name    = "arm-node-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["1433", "3306", "5432", "5000", "3000", "9000", "80", "8080", "6443", "2379-2380", "10250", "10259", "10257", "30000-32000"]
  }

  source_ranges = ["0.0.0.0/0"]  # Open ports from everywhere

  target_tags = ["arm-node-firewall"]
}
