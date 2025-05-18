output "image_url" {
  value = local.image_url
}

output "instance_ips" {
  value = [
    for instance in yandex_compute_instance_group.group-insommnia.instances : instance.network_interface[0].nat_ip_address
  ]
}

output "balancer_ip" {
  value = yandex_lb_network_load_balancer.load-balancer-insommnia.listener[*].external_address_spec[*].address
}
