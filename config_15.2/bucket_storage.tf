# create bucket
resource "yandex_storage_bucket" "bucket-insommnia" {
  bucket = "${lower(var.student_name)}-${formatdate("YYYYMMDD", timestamp())}"
  
  # 
    depends_on = [
    yandex_iam_service_account_static_access_key.key-insommnia,
    yandex_resourcemanager_folder_iam_binding.role-insommnia
  ]
  
  acl = "public-read"
  folder_id  = var.folder_id
  access_key = yandex_iam_service_account_static_access_key.key-insommnia.access_key
  secret_key = yandex_iam_service_account_static_access_key.key-insommnia.secret_key

  anonymous_access_flags {
    read = true
    list = true
  }
}

# add picture
resource "yandex_storage_object" "picture" {
  access_key = yandex_iam_service_account_static_access_key.key-insommnia.access_key
  secret_key = yandex_iam_service_account_static_access_key.key-insommnia.secret_key
  bucket       = yandex_storage_bucket.bucket-insommnia.id
  key          = "avatar.png"
  content_type = "png"
  source       = "/home/s_yaremko/clopro-homeworks/02/avatar.png"
}
