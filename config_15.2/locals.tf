locals {
  image_url = "https://storage.yandexcloud.net/${yandex_storage_bucket.bucket-insommnia.bucket}/${yandex_storage_object.picture.key}"
}
