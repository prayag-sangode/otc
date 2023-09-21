variable "stage" {
  description = "Stage name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_cidr" {
  description = "CIDR block for public subnet"
  type        = string
}

variable "private_cidr" {
  description = "CIDR block for private subnet"
  type        = string
}

variable "credential" {
  description = "OTC Credemtials"
  type = object({
    domain_name = string
    tenant_name = string
    auth_url    = string
  })
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

#variable "network_id" {
#  description = "Name of the image for the ECS VM"
#  type        = string
#}

