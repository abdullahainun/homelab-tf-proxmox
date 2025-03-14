variable "proxmox" {
  description = "Proxmox configuration"
  type = object({
    endpoint = string
    insecure = bool
    # username  = string
    # password  = optional(string)
    # api_token = optional(string)
    # ssh_agent = optional(string, false)
  })
  sensitive = true
}

variable "cluster" {
  description = "Cluster configuration"
  type = object({
    network_dhcp  = optional(bool, false)
    gateway       = string
    cidr          = number
    vlan_id       = optional(number, null)
    name          = string
    talos_version = optional(string, "v1.9.4")
    file_id       = string
  })
}

variable "vms" {
  description = "Configuration for cluster nodes"
  type = map(object({
    host_node      = string
    machine_type   = string
    datastore_id   = optional(string, "local-lvm")
    ip             = string
    cpu            = number
    ram_dedicated  = number
    os_disk_size   = number
    data_disk_size = number
    gpu            = optional(string)
  }))
}

variable "pci" {
  description = "Configuration mapping PCI"
  type = map(object({
    name         = string
    id           = string
    iommu_group  = number
    node         = string
    path         = string
    subsystem_id = string
  }))
  default = null
}
