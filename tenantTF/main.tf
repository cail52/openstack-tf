terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version >= "1.49.0"
    }
  }
}

provider "openstack" {
  user_name   = “tenant-user”
  tenant_name = “tenant”
  password    = “tenant”
  auth_url    = “OS_AUTH_URL”
  region      = “OS_REGION”
}

resource "openstack_compute_keypair_v2" "tenant-keypair" {
  name       = "tenant-key"
  public_key = "ssh-rsa ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
}


resource "openstack_networking_network_v2" "tenant-network" {
  name           = "tenant-network"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "tenant-subnet" {
  network_id = openstack_networking_network_v2.tenant-network.id
  name       = "tenant-subnet"
  cidr       = "192.168.26.0/24"
}

resource "openstack_networking_router_interface_v2" "tenant-router-interface" {
  router_id = “XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX”
  subnet_id = openstack_networking_subnet_v2.tenant-subnet.id
}

resource "openstack_compute_instance_v2" "tenant-instance" {
  name            = "tenant"
  image_id        = "YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY"
  flavor_id       = "3"
  key_pair        = "tenant-key"
  security_groups = ["default"]

  metadata = {
    this = "that"
  }

  network {
    name = "tenant-network"
  }
}
