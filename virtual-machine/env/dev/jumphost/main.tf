terraform {
  required_version = ">= 0.14"

  backend "s3" {
    endpoints = {
      s3 = "https://minio-api.abdullahainun.site" # Minio endpoint
    }
    bucket = "homelab-tf-proxmox"
    key    = "state/virtual-machine/jumphost"

    region                      = "main" # Region validation will be skipped
    skip_credentials_validation = true   # Skip AWS related checks and validations
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    use_path_style              = true # Enable path-style S3 URLs (https://<HOST>/<BUCKET> https://developer.hashicorp.com/terraform/language/settings/backends/s3#use_path_style
  }
}

module "jumphost" {
  source    = "../../../modules/virtual-machine-with-ubuntu-2404"
  name      = "jumphost"
  node_name = "pve0"
  vm_id     = 100
  resource = {
    ip                = "10.10.10.11"
    cpu               = 2
    ram_dedicated     = 8000
    path_in_datastore = "vm-100-disk-0"
    data_disk_size    = 100
    datastore_id      = "local-lvm"
    ip                = "192.168.43.99"
    cidr              = 24
    gateway           = "192.168.43.254"
  }
}
