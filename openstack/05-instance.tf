resource "openstack_compute_instance_v2" "test" {
  name            = "test-${count.index}"
  image_name      = "cirros-0.6.2-x86_64-disk"
  flavor_name     = "m1.tiny"
  key_pair        = "${openstack_compute_keypair_v2.my-cloud-key.name}"
  security_groups = ["secgroup_1"]
  count = 2

  network {
    name = "NET${count.index +1}"
  }
}

