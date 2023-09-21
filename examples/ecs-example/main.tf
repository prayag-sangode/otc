module "ecs_vm" {
  source      = "../../modules/ecs_vm"
  stage       = var.stage
  key_name    = var.key_name
  key_file    = var.key_file
  ssh_port    = var.ssh_port
  access_constraint = var.access_constraint
  flavor_id   = var.flavor_id
  image_name  = var.image_name
}
