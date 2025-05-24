# Create service account
resource "yandex_iam_service_account" "insommnia" {
  name        = "insommnia"
  folder_id   = var.folder_id
}

#Role
resource "yandex_resourcemanager_folder_iam_binding" "role-insommnia" {
  folder_id = var.folder_id
  role      = "admin"
  members   = [
    "serviceAccount:${yandex_iam_service_account.insommnia.id}"
  ]
}

#Create static key
resource "yandex_iam_service_account_static_access_key" "key-insommnia" {
  service_account_id = yandex_iam_service_account.insommnia.id
}

#Create encryption key

resource "yandex_kms_symmetric_key" "encryption-key" {
  name              = "encryption-key"
  description       = "yandex_kms_symmetric_key"
  default_algorithm = "AES_256"
  rotation_period   = "8760h"
}
