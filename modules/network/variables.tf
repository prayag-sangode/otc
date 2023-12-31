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


