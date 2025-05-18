resource "yandex_vpc_network" "network-insommnia" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "subnetwork-insommnia" {
  name           = var.vpc_name_public
  zone           = var.default_zone
  network_id     = yandex_vpc_network.network-insommnia.id
  v4_cidr_blocks = var.public_cidr
}
