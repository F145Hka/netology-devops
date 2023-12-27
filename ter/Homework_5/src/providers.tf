terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"

  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket   = "netology-tfstate-develop"
    region   = "ru-central1"
    key      = "terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    # skip_requesting_account_id  = true
    # skip_s3_checksum            = true

    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gfhjluvc715t6ebnri/etnjjdqtv7au56j38qok"
    dynamodb_table    = "tfstate-develop"
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}