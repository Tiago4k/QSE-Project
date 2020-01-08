provider "google" {
  credentials = "${file("CREDENTIALS_FILE.json")}"
  project     = "searchengine-262517"
  region      = "europe-west1"
}

resource "google_compute_instance" "es-stormcrawler-terra" {
  name         = "es-stormcrawler-terra"
  machine_type = "n1-highmem-2"
  zone         = "europe-west1-b"

  tags = ["server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1604-lts"
      size  = "200"
      type  = "pd-ssd"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }

  metadata = {
    sshKey = "tiago4k:${file("~/.ssh/id_rsa.pub")}"
  }

  metadata_startup_script = "${file("minimal_install.sh")}"
}


resource "google_compute_firewall" "http" {
  name    = "es-server-firewall"
  network = "default"


  allow {
    protocol = "tcp"
    ports    = ["9200", "9300", "5601"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["server"]
}
