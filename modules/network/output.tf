# In modules/network/output.tf

output "network_id" {
  value = opentelekomcloud_vpc_subnet_v1.public.id
}

output "network_name" {
  value = opentelekomcloud_vpc_subnet_v1.public.name
}

