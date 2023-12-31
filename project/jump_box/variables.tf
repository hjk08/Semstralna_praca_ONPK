# --- root/variables.tf ---

variable "username" {
  type = string
}
variable "password" {
  type = string
}
variable "tenant_name" {
  type = string
}

variable "flavor_name" {
  type = string
  default = "2c2r20d"
}

variable "environment" {
  type    = string
  default = "dev"
}