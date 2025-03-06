variable "proxmox" {
  description = "Proxmox configuration"
  type = object({
    endpoint = string
    insecure = bool
  })
  sensitive = true
}

variable "cluster" {
  description = "k8s Cluster Configuration"
}

variable "vms" {
  description = "VM Nodes"
}
