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
  default     = "nfs-repo:iso/metal-amd64.iso" # The ID format is <datastore_id>:<content_type>/<file_name>
  type        = string
  description = "proxmox file id"
}
