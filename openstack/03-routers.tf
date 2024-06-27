data "openstack_networking_network_v2" "public" {
      name = "public"
}
resource "openstack_networking_router_v2" "terraform" {
  name                = "VR1"
  admin_state_up      = "true"
  external_network_id = data.openstack_networking_network_v2.public.id
}

resource "openstack_networking_router_interface_v2" "if-net1" {
  router_id = openstack_networking_router_v2.terraform.id
  subnet_id = openstack_networking_subnet_v2.SUBNET1.id
}
resource "openstack_networking_router_interface_v2" "if-net2" {
  router_id = openstack_networking_router_v2.terraform.id
  subnet_id = openstack_networking_subnet_v2.SUBNET2.id
}
