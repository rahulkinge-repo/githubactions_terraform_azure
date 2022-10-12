variable client_id { 
    description = "Client ID"
    type        = string
    sensitive   = true
    default = "azure"
}
variable client_secret {
    description = "Client SECRET"
    type        = string
    sensitive   = true
    default = "*****"
}
variable ssh_public_key {
    description = "SSH KEY "
    type        = string
    sensitive   = true
    default = file(azure_rsa.pub)
}

variable environment {
    default = "dev"
}

variable location {
    default = "westus"
}

variable node_count {
  default = 1
}



variable dns_prefix {
  default = "k8stest"
}

variable cluster_name {
  default = "k8stest"
}

variable resource_group {
  default = "kubernetes"
}