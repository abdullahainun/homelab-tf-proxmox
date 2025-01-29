provider "proxmox" {
  # Configuration options
  endpoint = "https://pve1.abdullahainun.site:8006/"
}

resource "proxmox_virtual_environment_vm" "talos_template" {
  name      = "talos-template"
  node_name = "pve1"

  template = true

  machine     = "q35"
  bios        = "ovmf"
  description = "Managed by Terraform"

  agent {
    enabled = true
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 2048
  }

  efi_disk {
    datastore_id = "local"
    file_format  = "raw"
    type         = "4m"
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.talos_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 20
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    # user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id
  }

  network_device {
    bridge = "vmbr0"
  }

}

resource "proxmox_virtual_environment_download_file" "talos_cloud_image" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = "pve1"

  url = "https://factory.talos.dev/image/b8e8fbbe1b520989e6c52c8dc8303070cb42095997e76e812fa8892393e1d176/v1.9.2/metal-amd64.iso"
}
