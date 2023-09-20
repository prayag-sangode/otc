## VPC

resource "opentelekomcloud_vpc_v1" "nc_vpc" {
  name   = var.stage
  cidr   = var.vpc_cidr
  shared = false
  tags = {
    workspace = var.stage
  }
}

## Public Subnet

resource "opentelekomcloud_vpc_subnet_v1" "public" {
  name       = var.stage
  cidr       = var.public_cidr
  vpc_id     = opentelekomcloud_vpc_v1.nc_vpc.id
  gateway_ip = cidrhost(var.public_cidr, 1) ## Calculate the gateway IP address using the cidrhost function.

  tags = {
    workspace = var.stage
    scope     = "PUBLIC"
  }
}

## Private Subnet

resource "opentelekomcloud_vpc_subnet_v1" "private" {
  name       = var.stage
  cidr       = var.private_cidr
  vpc_id     = opentelekomcloud_vpc_v1.nc_vpc.id
  gateway_ip = cidrhost(var.private_cidr, 1)

  tags = {
    workspace = var.stage
    scope     = "PRIVATE"
  }
}

## NAT Gateway

resource "opentelekomcloud_nat_gateway_v2" "nc_nat" {
  name                = var.stage
  description         = "NAT GW"
  spec                = "1"
  router_id           = opentelekomcloud_vpc_v1.nc_vpc.id
  internal_network_id = opentelekomcloud_vpc_subnet_v1.public.id

  tags = {
    workspace = var.stage
  }
}

# EIP for SNAT

resource "opentelekomcloud_networking_floatingip_v2" "snat_public_ip" {
}

# SNAT Links

resource "opentelekomcloud_nat_snat_rule_v2" "nc_snat_public" {
  nat_gateway_id = opentelekomcloud_nat_gateway_v2.nc_nat.id
  floating_ip_id = opentelekomcloud_networking_floatingip_v2.snat_public_ip.id
  network_id     = opentelekomcloud_vpc_subnet_v1.public.id
  source_type    = 0
}

resource "opentelekomcloud_nat_snat_rule_v2" "nc_snat_private" {
  nat_gateway_id = opentelekomcloud_nat_gateway_v2.nc_nat.id
  floating_ip_id = opentelekomcloud_networking_floatingip_v2.snat_public_ip.id
  network_id     = opentelekomcloud_vpc_subnet_v1.private.id
  source_type    = 0
}


