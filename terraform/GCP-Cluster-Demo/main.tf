provider "google" {
  credentials = "${file("CREDENTIALS_FILE.json")}"
  project     = "searchengine-262517"
  region      = "europe-west1"
}

/*
  Elasticsearch Node 1
*/

resource "google_compute_instance" "es-stormcrawler-node-1" {
  name         = "es-stormcrawler-node-1"
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


/*
  Elasticsearch Node 2
*/

resource "google_compute_instance" "es-stormcrawler-node-2" {
  name         = "es-stormcrawler-node-2"
  machine_type = "n1-highmem-2"
  zone         = "europe-west2-c"

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


/*
  Elasticsearch Node 3
*/

resource "google_compute_instance" "es-stormcrawler-node-3" {
  name         = "es-stormcrawler-node-3"
  machine_type = "n1-highmem-2"
  zone         = "europe-west4-a"

  tags = ["server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1604-lts"
      size  = "100"
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

/*
  Elasticsearch Node 4
*/


resource "google_compute_instance" "es-stormcrawler-node-4" {
  name         = "es-stormcrawler-node-4"
  machine_type = "n1-highmem-2"
  zone         = "europe-west3-a"

  tags = ["server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1604-lts"
      size  = "100"
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

/*
  Elasticsearch Node 5
*/


resource "google_compute_instance" "es-stormcrawler-node-5" {
  name         = "es-stormcrawler-node-5"
  machine_type = "n1-highmem-2"
  zone         = "europe-west4-a"

  tags = ["server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1604-lts"
      size  = "100"
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



/*
  Firewall rules for all nodes
*/

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
