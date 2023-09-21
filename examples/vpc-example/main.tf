module "network" {
  source       = "../../modules/network"
  stage        = var.stage
  vpc_cidr     = var.vpc_cidr
  public_cidr  = var.public_cidr
  private_cidr = var.private_cidr
}
output "network_id" {
  value = module.network.network_id
}
