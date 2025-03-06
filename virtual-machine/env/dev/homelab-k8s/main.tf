terraform {
  required_version = ">= 0.14"

  backend "s3" {
    endpoints = {
      s3 = "https://minio-api.abdullahainun.site" # Minio endpoint
    }
    bucket = "homelab-tf-proxmox"
    key    = "state/virtual-machine/homelab-k8s"

    region                      = "main" # Region validation will be skipped
    skip_credentials_validation = true   # Skip AWS related checks and validations
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    use_path_style              = true # Enable path-style S3 URLs (https://<HOST>/<BUCKET> https://developer.hashicorp.com/terraform/language/settings/backends/s3#use_path_style
  }
}

module "homelab_k8s_cluster" {
  source  = "../../../modules/virtual-machine-with-talos/"
  proxmox = var.proxmox

  cluster = {
    name     = "homelab-k8s"
    gateway  = "10.10.10.1"
    cidr     = 24
    vlan_id  = "200"
    endpoint = "10.10.10.10"
  }

  vms = {
    "cp-0" = {
      host_node      = "pve0"
      machine_type   = "controlplane"
      ip             = "10.10.10.10"
      cpu            = 2
      ram_dedicated  = 4096
      os_disk_size   = 10
      data_disk_size = 30
      datastore_id   = "local-lvm"
    },
    "cp-1" = {
      host_node      = "pve1"
      machine_type   = "controlplane"
      ip             = "10.10.10.11"
      cpu            = 2
      ram_dedicated  = 4096
      os_disk_size   = 10
      data_disk_size = 30
      datastore_id   = "local-lvm"
    },
    "cp-2" = {
      host_node      = "pve2"
      machine_type   = "controlplane"
      ip             = "10.10.10.12"
      cpu            = 2
      ram_dedicated  = 4096
      os_disk_size   = 10
      data_disk_size = 30
      datastore_id   = "local-lvm"
    }
  }

}
