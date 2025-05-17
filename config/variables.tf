###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
  #default = ""
  #sensitive = true
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
  #default = ""
  #sensitive = true
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
  #default = ""
  #sensitive = true
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "public_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "private_cidr" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "test-network"
  description = "VPC network&subnet name"
}

variable "vpc_name_public" {
  type        = string
  default     = "public"
  description = "VPC network&subnet name"
}

variable "vpc_name_private" {
  type        = string
  default     = "private"
  description = "VPC network&subnet name"
}

variable "vm_resources" {
  type = map
  default = {
  cores = "2" 
  memory = "2"
  core_fraction = "20"
  platform_id = "standard-v1"
  }
}

variable "vm_def" {
  type = bool
  default = true
  
}

variable "vm_nat_name" {
  type = string
  default = "nat-instance"
  
}

variable "vm_public_name" {
  type = string
  default = "public-instance"
  
}

variable "vm_private_name" {
  type = string
  default = "private-instance"
  
}

variable "routing_name" {
  type = string
  default = "test-routing"
  
}

variable "des_pre" {
  type = string
  default = "0.0.0.0/0"
  
}

variable "nat_image_id" {
  type = string
  default = "fd80mrhj8fl2oe87o4e1"
  
}

variable "nat_ip_address" {
  type = string
  default = "192.168.10.254"
  
}

variable "vm_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "yandex_compute_image_family"
}

variable "vms_ssh_root_key" {
  description = "metadata for all vms"
  type        = map(string)
  default     = {
    serial-port-enable = "1"
    ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMIgCTAknACY9siTMrK+ozJsJoFis+9ePIUyAC8YYd/K s_yaremko@Ubuntu-50Gb"
  }
}
