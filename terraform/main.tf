terraform {
    required_version = "0.13.2"
}

provider "google" {
  version = "3.5.0"

  credentials = file("/key/key-deployer-learn.json")

  project   = "learn-286016"
  region    = "europe-west3"
  zone      = "europe-west3-c"
}

resource "google_compute_network" "vpc-web-network" {
  name = "we-terraform-network"
}

# resource "google_compute_address" "vm_static_ip" {
#   name = "terraform-static-ip"
# }

resource "google_storage_bucket" "web_bucket" {
  name     = "alex-viki-web"

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

resource "google_compute_instance" "web-srv" {
    name            = "web-ser-01"
    machine_type    = "g1-small"
#    zone            = "europe-west1-b"
    tags            = ["web-srv", "web-test"]

    metadata = {
        ssh-keys    = "appuser:${file("/key/gcp_learn.pub")}"
    }

    boot_disk {
        initialize_params {
#It was created in previous laba_15 (https://github.com/AlexViki/laba_15_packer_gcp_image)
#also can pass: packer-ubuntu-1804-1599501778
            image   = "web-ubuntu-18"
        }
    }

    network_interface {
        network     = google_compute_network.vpc-web-network.self_link
        access_config {
#            nat_ip = google_compute_address.vm_static_ip.address
        }
    }

    provisioner "local-exec" {
        command = "echo ${google_compute_instance.web-srv.name}:  ${google_compute_instance.web-srv.network_interface[0].access_config[0].nat_ip} >> /tmp/ip_address.txt"
    }

    depends_on = [google_storage_bucket.web_bucket]
}