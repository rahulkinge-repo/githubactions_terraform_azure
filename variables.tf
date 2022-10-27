variable ssh_public_key {
    description = "SSH KEY "
    sensitive   = true
    default = "azure_rsa.pub"
}

variable client_secret {
    description = "client secret"
    sensitive   = true
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