# --- main.tf ---

data "http" "my_public_ip" {
  url = "http://ipv4.icanhazip.com"
}

resource "openstack_compute_keypair_v2" "keypair" {
  name       = "ONPK2-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEc3eVfn/wjRcWWEoZjBXiCW5lwrLh2A11fuPZcKl1GSAg5OtLSKacJXHjKGLnuJVqFPxiLT4A0OPc9A0gk8TRueNi7mfauKiHjlldcI2oF9ueMyyhBvyHtcsHftG4iUJ4Za3KvsDwXM1UdRFO17tgxXrwcYhe0T1wYIbeLvO8L+Vembec+sp81sL8UM7jjc94hve1JP6j2B91/i+s8UecZqTx5cvFHZghRk8BpsD62CWGEosbYOb9iqq29NuypJrQzScEjUnnZ2AAi9iNaebqn8ECdOOXv7NqOEVOBG0xPZtoH0DKlIUYS9uVQXLNsHIqfOIpeckVfb/fVSCEz4lr"
}

data "cloudinit_config" "user_data"{
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    filename     = "network_set_up"
    content      = file("${path.module}/scripts/base.sh")
  }
}

data "openstack_networking_network_v2" "private_network" {
  name = "local_private"
}

module "instance2" {
  source                = "github.com/hjk08/Semstralna_praca_ONPK/modules/compute"
  instance_name         = "private_server"
  sec_group_name        = "server_sec_gr"
  static_ip             = "10.10.10.43"
  keypair               = openstack_compute_keypair_v2.keypair.name
  my_public_ip          = data.http.my_public_ip.response_body
  private_network_name  = data.openstack_networking_network_v2.private_network.name
  user_data             = data.cloudinit_config.user_data.rendered
}
