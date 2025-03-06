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

module "k8s-cpl" {
  source      = "../../../modules/virtual-machine-with-talos/"
  name        = "k8s-cpl"
  description = "homelab-k8s control plane"
  node_name   = "pve1"
  vm_id       = 103
  vlan_id     = 200
}
