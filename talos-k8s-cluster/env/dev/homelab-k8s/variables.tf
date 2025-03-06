variable "proxmox" {
  description = "Proxmox configuration"
  type = object({
    endpoint = string
    insecure = bool
  })
  sensitive = true
}

variable "cluster" {
  description = "Cluster configuration"
  type = object({
    name                  = string
    talos_version         = optional(string, "v1.9.4")
    file_id               = string
    network_dhcp          = optional(bool, false)
    gateway               = optional(string)
    cidr                  = optional(number)
    vlan_id               = optional(number, null)
    network_device_bridge = optional(string, "vmbr0")
    endpoint              = optional(string)
  })
}

variable "vms" {
  description = "VMs configuration"
  type = map(object({
    host_node        = string
    machine_type     = string
    datastore_id     = optional(string, "local-lvm")
    ip               = optional(string)
    cpu              = number
    ram_dedicated    = number
    os_disk_size     = optional(number, 10)
    data_disk_size   = optional(number, 20)
    install_disk     = optional(string, "/dev/sda")
    disk_file_format = optional(string, "raw")
    gpu              = optional(string)
  }))
}

variable "certificate" {
  description = "Certificate for k8s sealed-secrets"
  type = object({
    cert = string
    key  = string
  })
  default = null
}
