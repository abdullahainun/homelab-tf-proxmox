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
  default     = "1234"
  type        = string
  description = "proxmox virtual machine id"
}
