terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "1.49.0"
    }
  }
}

provider "openstack" {
  user_name   = “OS_USERNAME”
  tenant_name = “admin”
  password    = “OS_PASSWORD”
  auth_url    = “OS_AUTH_URL”
  region      = “OS_REGION”
}

resource "openstack_compute_flavor_v2" "small-flavor" {
  name      = "small"
  ram       = "4096"
  vcpus     = "1"
  disk      = "0"
  flavor_id = "1"
  is_public = "true"
}

resource "openstack_compute_flavor_v2" "medium-flavor" {
  name      = "medium"
  ram       = "8192"
  vcpus     = "2"
  disk      = "0"
  flavor_id = "2"
  is_public = "true"
}

resource "openstack_compute_flavor_v2" "large-flavor" {
  name      = "large"
  ram       = "16384"
  vcpus     = "4"
  disk      = "0"
  flavor_id = "3"
  is_public = "true"
}

resource "openstack_compute_flavor_v2" "xlarge-flavor" {
  name      = "xlarge"
  ram       = "32768"
  vcpus     = "8"
  disk      = "0"
  flavor_id = "4"
  is_public = "true"
}

resource "openstack_networking_network_v2" "external-network" {
  name           = "external-network"
  admin_state_up = "true"
  external       = "true"
  segments {
    network_type     = "flat"
    physical_network = "physnet1"
  }
}

resource "openstack_networking_subnet_v2" "external-subnet" {
  name            = "external-subnet"
  network_id      = openstack_networking_network_v2.external-network.id
  cidr            = "10.0.0.0/8"
  gateway_ip      = "10.0.0.1"
  dns_nameservers = ["10.0.0.254", "10.0.0.253"]
  allocation_pool {
    start = "10.0.0.1"
    end   = "10.0.254.254"
  }
}
resource "openstack_images_image_v2" "cirros" {
  name             = "cirros"
  image_source_url = "https://download.cirros-cloud.net/0.6.1/cirros-0.6.1-x86_64-disk.img"
  container_format = "bare"
  disk_format      = "qcow2"

  properties = {
    key = "value"
  }
}

resource "openstack_identity_project_v3" "tenant-project" {
  name = "Demo"
}

resource "openstack_identity_user_v3" "tenant-user" {
  name               = "tenant-user"
  default_project_id = openstack_identity_project_v3.tenant-project.id
  password = "demo"
}
