# Environmental variables

variable "appId" {
  description = "Azure Kubernetes Service Cluster service principal"
  type = string
}

variable "password" {
  description = "Azure Kubernetes Service Cluster password"
  type = string
}

variable "tenant_id" {
  description = "Azure tenant_id"
  type = string
}

variable "object_id" {
    description = "Azure object_id"
    type = string
}