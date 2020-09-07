terraform {
    required_version = "0.13.2"
}
provider "google" {
    project = "learn-286016"
    region = "europe-west3"
}

resource "google_compute_instance" "web-ser" {
    name            = "web-ser-01"
    machine_type    = "g1-small"
    zone            = "europe-west1-b"
    tags            = ["web-ser"]

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
        network     = "default"
        access_config {}
    }
}