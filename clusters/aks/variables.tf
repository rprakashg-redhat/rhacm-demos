variable "resourcegroup" {
  description = "Azure resource group name"
  type        = string
}

variable "region" {
  description = "Azure region"
  type        = string
  default     = "West US 2"
}

variable "appId" {
  description = "Azure Kubernetes Service Cluster service principal"
  type        = string
}

variable "password" {
  description = "Azure Kubernetes Service Cluster password"
  type        = string 
}

variable "tenant" {
  description = "Azure Tenant"
  type        = string 
}

variable "subscription" {
  description = "Azure Subscription"
  type        = string 
}
