variable "stage" {
  type        = string
  description = "Project qualifier for tags an unique resource names"
  default     = "vllm-hub"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block of the public subnet"
  default     = "10.0.0.0/8"
}

variable "public_cidr" {
  type        = string
  description = "CIDR block of the public subnet"
  default     = "10.0.1.0/24"
}

variable "private_cidr" {
  type        = string
  description = "CIDR block of the private subnet"
  default     = "10.0.0.0/24"
}

variable "credential" {
  description = "OTC Credemtials"
  type = object({
    domain_name = string
    tenant_name = string
    auth_url    = string
  })
  default = {
    domain_name = "OTC00000000001000101583"
    tenant_name = "eu-de"
    auth_url    = "https://iam.eu-de.otc.t-systems.com/v3"
  }
}

variable "key_name" {
  type        = string
  description = "SSH Key resource name for the vllm-hub-node host"
}

variable "key_file" {
  type        = string
  description = "Public Key file name for the vllm-hub-node host"
}

variable "key_pvt_file" {
  type        = string
  description = "Public Key file name for the vllm-hub-node host"
}

variable "ssh_port" {
  type        = number
  description = "SSH Port of vllm-hub-node"
  default     = 22
}
variable "access_constraint" {
  type        = string
  description = "CIDR of machines that are allowed to access the vllm-hub-node"
  default     = "0.0.0.0/0"
}

variable "image_name" {
  type        = string
  description = "Image name for vllm-hub-node"
}

variable "flavor_id" {
  type        = string
  description = "Image name for vllm-hub-node"
}

#variable "vcpus" {
#  type        = string
#  description = "CPUs for vllm-hub-node"
#}

#variable "ram" {
#  type        = string
#  description = "RAM for vllm-hub-node"
#}

variable "ssh_user_name" {
  type        = string
  description = "logon account for instantiated image"
}
