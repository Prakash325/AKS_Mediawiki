variable "agent_count" {
    default = 2
}

variable "ssh_public_key" {
    #default = "~/.ssh/id_rsa.pub"
}

variable cluster_name {
    default = "aks-mediawiki-dev"
}

variable resource_group_name {
    default = "azure-aks-mediawiki-dev"
}

variable location {
    default = "Central US"
}
