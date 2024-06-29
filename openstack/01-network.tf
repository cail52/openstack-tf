resource "openstack_networking_network_v2" "NET1" {
  name           = var.net1-name
  admin_state_up = "true"
}
resource "openstack_networking_network_v2" "NET2" {
  
  name           = var.net2-name
  admin_state_up = "true"
}


resource "openstack_networking_subnet_v2" "SUBNET1"{

   name = var.subnet-name-1
   network_id = openstack_networking_network_v2.NET1.id
   cidr       = "192.168.1.0/24"
   
}

resource "openstack_networking_subnet_v2" "SUBNET2"{

   name = var.subnet-name-2
   network_id = openstack_networking_network_v2.NET2.id
   cidr       = "192.168.2.0/24"
   
}
  
resource "openstack_networking_floatingip_v2" "fip" {
  pool = "public"
}


#resource "openstack_compute_floatingip_associate_v2" "fip-associate" {
#floating_ip = openstack_networking_floatingip_v2.fip.address
#instance_id = openstack_compute_instance_v2.test-0
#}
