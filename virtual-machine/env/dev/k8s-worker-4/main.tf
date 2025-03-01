terraform {
  required_version = ">= 0.14"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.70.0"
    }
  }

  backend "s3" {
    endpoints = {
      s3 = "https://minio-api.abdullahainun.site" # Minio endpoint
    }
    bucket = "homelab-tf-proxmox"
    key    = "state/virtual-machine/k8s-worker-4"

    region                      = "main" # Region validation will be skipped
    skip_credentials_validation = true   # Skip AWS related checks and validations
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    use_path_style              = true # Enable path-style S3 URLs (https://<HOST>/<BUCKET> https://developer.hashicorp.com/terraform/language/settings/backends/s3#use_path_style
  }

}

provider "proxmox" {
  endpoint = "https://pve.abdullahainun.site/"
  insecure = true
  ssh {
    agent = true
  }
}

module "k8s-worker-4" {
  source      = "../../../modules/virtual-machine-with-talos/"
  name        = "k8s-worker-4"
  description = "Worker node number 4 of homelab-k8s"
  node_name   = "pve3"
  vm_id       = 105
}
