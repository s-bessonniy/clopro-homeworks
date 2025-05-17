output "Create_Instance" {
  value = {
    external_ip_NAT = yandex_compute_instance.nat-instance.network_interface.0.nat_ip_address
    external_ip_Public-Instance = yandex_compute_instance.public-instance.network_interface.0.nat_ip_address
    internal_ip_Private-Instance = yandex_compute_instance.private-instance.network_interface.0.ip_address
  }
}
