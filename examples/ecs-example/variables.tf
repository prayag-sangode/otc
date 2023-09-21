variable "credential" {
  description = "OTC Credemtials"
  type = object({
    domain_name = string
    tenant_name = string
    auth_url    = string
  })
}

variable "stage" {
  description = "The stage of the environment"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key"
  type        = string
}

variable "key_file" {
  description = "Path to the public SSH key file"
  type        = string
}

variable "ssh_port" {
  description = "SSH port for security group rule"
  type        = number
}

variable "access_constraint" {
  description = "CIDR block for security group rule"
  type        = string
}

variable "flavor_id" {
  description = "ID of the flavor for the ECS VM"
  type        = string
}

variable "image_name" {
  description = "Name of the image for the ECS VM"
  type        = string
}
