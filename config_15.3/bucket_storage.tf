# create bucket
resource "yandex_storage_bucket" "bucket-insommnia" {
  bucket = "${lower(var.student_name)}-${formatdate("YYYYMMDD", timestamp())}"
  
  #folder_id  = var.folder_id
  access_key = yandex_iam_service_account_static_access_key.key-insommnia.access_key
  secret_key = yandex_iam_service_account_static_access_key.key-insommnia.secret_key

  server_side_encryption_configuration {
    rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = yandex_kms_symmetric_key.encryption-key.id
      sse_algorithm     = "aws:kms"
      }
    }
  }
}

# add picture
resource "yandex_storage_object" "picture" {
  access_key = yandex_iam_service_account_static_access_key.key-insommnia.access_key
  secret_key = yandex_iam_service_account_static_access_key.key-insommnia.secret_key
  bucket       = yandex_storage_bucket.bucket-insommnia.id
  key          = "avatar.png"
  content_type = "png"
  source       = "/home/s_yaremko/clopro-homeworks/03/avatar.png"
  acl = "public-read"
}
