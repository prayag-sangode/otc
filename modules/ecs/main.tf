#SSH key

resource "opentelekomcloud_compute_keypair_v2" "ecs-vm-keypair" {
  name       = var.key_name
  public_key = file(var.key_file)
}

# Security group for the ecs-vm

resource "opentelekomcloud_networking_secgroup_v2" "nc_ssh_ecs-vm_sg" {
  name        = format("%s_ssh_sg", var.stage)
  description = "SSH Access to the ecs-vm"
}

# Security group rule for the ecs-vm

resource "opentelekomcloud_networking_secgroup_rule_v2" "nc_ssh_ecs-vm_sg_rule" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = var.ssh_port
  port_range_max    = var.ssh_port
  remote_ip_prefix  = var.access_constraint
  security_group_id = opentelekomcloud_networking_secgroup_v2.nc_ssh_ecs-vm_sg.id
}

# ecs-vm server image

data "opentelekomcloud_images_image_v2" "ecs-vm_image" {
  name = var.image_name
}

# ecs-vm server flavor

#data "opentelekomcloud_compute_flavor_v2" "ecs-vm_flavor" {
#  vcpus = var.vcpus
#  ram   = var.ram
#}

# ecs-vm server VM

resource "opentelekomcloud_compute_instance_v2" "ecs-vm" {
  name              = format("%s", var.stage)
  image_id          = data.opentelekomcloud_images_image_v2.ecs-vm_image.id
  flavor_id         = var.flavor_id
  key_pair          = var.key_name
  security_groups   = ["default", opentelekomcloud_networking_secgroup_v2.nc_ssh_ecs-vm_sg.name]
  availability_zone = "eu-de-03"
  network {
    uuid = opentelekomcloud_vpc_subnet_v1.public.id
  }
  user_data = <<-EOF
              #!/bin/bash
              echo "Running user-initiated script"
              sudo apt-get update
              sudo apt-get install -y ansible
              sudo adduser --disabled-password --gecos "" prayag
              sudo adduser --disabled-password --gecos "" devops
              echo 'prayag ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers
              echo 'devops ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers
              sudo mkdir /home/prayag/.ssh
              sudo mkdir /home/devops/.ssh
              echo '${var.key_file}' > /home/prayag/.ssh/authorized_keys
              echo '${var.key_file}' > /home/devops/.ssh/authorized_keys
              sudo chown -R prayag:prayag /home/prayag/.ssh
              sudo chown -R devops:devops /home/devops/.ssh
              sudo chmod 700 /home/prayag/.ssh
              sudo chmod 700 /home/devops/.ssh
              sudo chmod 600 /home/prayag/.ssh/authorized_keys
              sudo chmod 600 /home/devops/.ssh/authorized_keys
              EOF
}

#resource "opentelekomcloud_blockstorage_volume_v2" "vllm-hub-vol" {
#  name = "vllm-hub-vol"
#  size = 80
#  availability_zone = "eu-de-03"
#}

#resource "opentelekomcloud_compute_volume_attach_v2" "attached" {
#  instance_id = opentelekomcloud_compute_instance_v2.ecs-vm.id
#  volume_id   = opentelekomcloud_blockstorage_volume_v2.vllm-hub-vol.id
#}

## EIP for ecs-vm

#resource "opentelekomcloud_networking_floatingip_v2" "ecs-vm_public_ip" {
#}

## Bind the floating IP to ecs-vm

resource "opentelekomcloud_networking_floatingip_associate_v2" "ecs-vm_associate" {
  floating_ip = opentelekomcloud_networking_floatingip_v2.snat_public_ip.address
  port_id     = opentelekomcloud_compute_instance_v2.ecs-vm.network.0.port
}

