  output "external_ip" {
    value = "${google_compute_instance.es-stormcrawler-terra.network_interface.0.access_config.0.nat_ip}"
  }