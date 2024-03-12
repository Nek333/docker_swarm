terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~>0.65.0"
    }
  }
}
provider "yandex" {
  token     = "y0_AgAAAAAY7WZeAATuwQAAAADebF5-9ENv5CrvTxqd64QoeNKYmTfOdes"
  cloud_id  = "b1gko7otatt45nppomok"
  folder_id = "b1g4q5tlm30vjh648j62"
  zone      = "ru-central1-a"
}

resource "yandex_vpc_network" "network" {
  name = "swarm-network"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

module "swarm_cluster" {
  source        = "./modules"
  vpc_subnet_id = yandex_vpc_subnet.subnet.id
  managers      = 1
  workers       = 1
}
