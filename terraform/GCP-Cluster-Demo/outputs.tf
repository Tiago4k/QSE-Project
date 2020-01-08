output "external_ip" {
  value = "${google_compute_instance.es-stormcrawler-node-1.network_interface.0.access_config.0.nat_ip}"
}
