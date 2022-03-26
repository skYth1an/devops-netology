terraform {
  required_providers {
    yandex = {
      source = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.72.0"
}

provider "yandex" {
  token     = "${var.yc_token}"
  cloud_id  = "${var.cloud_id}"
  folder_id = "${var.folder_id}"
  zone      = "ru-central1-a"
}

data "yandex_compute_image" "my_image" {
  family = "ubuntu-1804-lts"
}


locals	{
  sourse = {
   stage = 1
   prod = 2
 }
}



resource "yandex_compute_instance" "default" {
    count = local.sourse[terraform.workspace]

  resources {
   cores  = 2
   memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "${data.yandex_compute_image.my_image.id}"
    }
  }

  network_interface {
    subnet_id = "e9ba4rp2cnfki5vhakfm"
    nat       = true
  }

}
