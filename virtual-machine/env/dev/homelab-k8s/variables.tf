variable "proxmox" {
  description = "Proxmox configuration"
  type = object({
    endpoint = string
    insecure = bool
  })
  sensitive = true
}
