# provider "proxmox" {
#   endpoint      = var.proxmox.endpoint
#   # api_token     = var.proxmox.api_token
#   insecure      = var.proxmox.insecure
#   tmp_dir       = "/tmp"
#   random_vm_ids = true
#   ssh {
#     agent    = var.proxmox.ssh_agent
#     username = var.proxmox.username
#     password = var.proxmox.password
#   }
# }

provider "proxmox" {
  endpoint = "https://pve.abdullahainun.site/"
  insecure = true
  ssh {
    agent = true
  }
}
