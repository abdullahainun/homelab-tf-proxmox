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
  description = "worker node of homelab-k8s cluster"
  tags        = ["homelab-k8s", "talos", "worker"]

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
    cores = 2
    type  = "x86-64-v2-AES" # recommended for modern CPUs
  }

  memory {
    dedicated = 2048
    floating  = 2048 # set equal to dedicated to enable ballooning
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.iso.id
    interface    = "scsi0"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
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

resource "proxmox_virtual_environment_download_file" "iso" {
  content_type = "iso"
  datastore_id = "nfs-repo"
  node_name    = var.node_name
  url          = "https://factory.talos.dev/image/376567988ad370138ad8b2698212367b8edcb69b5fd68c80be1f2ec7d603b4ba/v1.9.2/metal-amd64.iso"

  lifecycle {
    create_before_destroy = false
    prevent_destroy       = true
  }
}
