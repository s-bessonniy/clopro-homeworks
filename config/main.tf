resource "yandex_vpc_network" "test-network" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "public-network" {
  name           = var.vpc_name_public
  zone           = var.default_zone
  network_id     = yandex_vpc_network.test-network.id
  v4_cidr_blocks = var.public_cidr
}

resource "yandex_vpc_subnet" "private-network" {
  name           = var.vpc_name_private
  zone           = var.default_zone
  network_id     = yandex_vpc_network.test-network.id
  v4_cidr_blocks = var.private_cidr
  route_table_id = yandex_vpc_route_table.test-routing.id
}

resource "yandex_vpc_route_table" "test-routing" {
  name       = var.routing_name
  network_id = yandex_vpc_network.test-network.id
  static_route {
    destination_prefix = var.des_pre
    next_hop_address   = var.nat_ip_address
  }
}

resource "yandex_compute_instance" "nat-instance" {
  name        = var.vm_nat_name
  hostname    = var.vm_nat_name
  platform_id = var.vm_resources.platform_id
  metadata    = var.vms_ssh_root_key
  
  resources {
    cores         = var.vm_resources.cores
    memory        = var.vm_resources.memory
    core_fraction = var.vm_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.nat_image_id
    }
  }

  scheduling_policy {
    preemptible = var.vm_def
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public-network.id
    ip_address = var.nat_ip_address
    nat       = var.vm_def
  }
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_image_family
}

resource "yandex_compute_instance" "public-instance" {
  name        = var.vm_public_name
  hostname    = var.vm_public_name
  platform_id = var.vm_resources.platform_id
  metadata    = var.vms_ssh_root_key
  
  resources {
    cores         = var.vm_resources.cores
    memory        = var.vm_resources.memory
    core_fraction = var.vm_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = var.vm_def
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public-network.id
    nat       = var.vm_def
  }
}

resource "yandex_compute_instance" "private-instance" {
  name        = var.vm_private_name
  hostname    = var.vm_private_name
  platform_id = var.vm_resources.platform_id
  metadata    = var.vms_ssh_root_key
  
  resources {
    cores         = var.vm_resources.cores
    memory        = var.vm_resources.memory
    core_fraction = var.vm_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = var.vm_def
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private-network.id
  }
}
