terraform {
  required_version = ">= 0.14"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.70.0"
    }
  }

  backend "s3" {
    bucket = "homelab-tools-terraform"
    key    = "virtual-machine/templates/talos"
    endpoints = {
      s3 = "https://minio-api.abdullahainun.site" # Minio endpoint
    }

    access_key = var.s3_access_key
    secret_key = var.s3_secret_key

    region                      = "main" # Region validation will be skipped
    skip_credentials_validation = true   # Skip AWS related checks and validations
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    use_path_style              = true # Enable path-style S3 URLs (https://<HOST>/<BUCKET> https://developer.hashicorp.com/terraform/language/settings/backends/s3#use_path_style
  }

}

module "default" {
  source        = "../../../modules/virtual-machine-with-talos-template/"
  s3_access_key = var.s3_access_key
  s3_secret_key = var.s3_secret_key
  pve_username  = var.pve_username
  pve_password  = var.pve_password
}
