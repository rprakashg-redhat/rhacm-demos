variable "appId" {
  description = "Azure Kubernetes Service Cluster service principal"
}

variable "password" {
  description = "Azure Kubernetes Service Cluster password"
}

variable "region" {
  description = "Azure region"
  type        = string
  default     = "West US 2"
}