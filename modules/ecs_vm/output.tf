# Inside the ecs_vm module (ecs_vm/main.tf or similar file)

output "ecs_vm_ip" {
  value = opentelekomcloud_networking_floatingip_v2.ecs_vm_public_ip.address
}
