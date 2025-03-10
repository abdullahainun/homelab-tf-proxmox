terraform {
  required_version = ">= 0.14"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.70.0"
    }
  }
}

provider "proxmox" {
  endpoint = "https://pve.abdullahainun.site/"
  insecure = true
  ssh {
    agent = true
  }
}

resource "proxmox_virtual_environment_vm" "vm" {
  name        = var.name
  description = "jumhost machine"
  tags        = ["vm", "ubuntu", "jumphost"]
  on_boot     = true
  started     = true

  node_name = var.node_name
  vm_id     = var.vm_id

  agent {
    # read 'Qemu guest agent' section, change to true only when ready
    enabled = false
  }
  # if agent is not enabled, the VM may not be able to shutdown properly, and may need to be forced off
  stop_on_destroy = true

  startup {
    order      = "3"
    up_delay   = "60"
    down_delay = "60"
  }

  cpu {
    cores = var.resource.cpu
    type  = "host"
  }

  memory {
    dedicated = var.resource.ram_dedicated
  }

  disk {
    datastore_id = var.resource.datastore_id
    interface    = "scsi0"
    iothread     = true
    cache        = "writethrough"
    discard      = "on"
    ssd          = true
    file_format  = "raw"
    size         = var.resource.data_disk_size
  }

  initialization {
    datastore_id = var.resource.datastore_id
    ip_config {
      ipv4 {
        address = var.resource == true ? "dhcp" : "${var.resource.ip}/${var.resource.cidr}"
        gateway = var.resource == true ? null : var.resource.gateway
      }
    }
  }


  network_device {
    bridge = "vmbr0"
  }

  operating_system {
    type = "l26"
  }

  tpm_state {
    version = "v2.0"
  }

  serial_device {}
}
