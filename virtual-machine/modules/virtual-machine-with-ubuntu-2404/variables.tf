variable "name" {
  default     = "vm1"
  type        = string
  description = "virtual machine name"
}


variable "node_name" {
  default     = "pve1"
  type        = string
  description = "proxmox node name"
}

variable "vm_id" {
  default     = 1234
  type        = number
  description = "proxmox virtual machine id"
}

variable "file_id" {
  default     = "nfs-repo:iso/ubuntu-24.04.1-live-server-amd64.iso" # The ID format is <datastore_id>:<content_type>/<file_name>
  type        = string
  description = "proxmox file id"
}

variable "resource" {
  description = "resource specification for virtual machine"
  type = object({
    datastore_id   = optional(string, "local-lvm")
    ip             = string
    cpu            = number
    ram_dedicated  = number
    data_disk_size = number
    gpu            = optional(string)
    cidr           = string
    gateway        = string
  })
}
