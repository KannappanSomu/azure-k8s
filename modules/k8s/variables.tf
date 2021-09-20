variable "resource_group_name" {
  type    = string
}

variable "location" {
  type    = string
}

variable "cluster_name" {
  type    = string
  default = "aks-cluster"
}

variable "dns_prefix" {
    default = "aks-cluster"
    type    = string
}

variable "vnet_subnet_id" {
    type    = string
}

variable "node_resource_group" {
    type    = string
    default = "aks-kanna"
}

variable "client_secret" {
}

variable "client_id" {
}