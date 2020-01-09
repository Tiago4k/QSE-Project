variable "name" {
  default = "qse-cluster"
}
variable "project" {
  default = "searchengine-262517"
}

variable "location" {
  default = "europe-west4"
}

variable "initial_node_count" {
  default = 1
}

variable "machine_type" {
  default = "n1-standard-1"
}
