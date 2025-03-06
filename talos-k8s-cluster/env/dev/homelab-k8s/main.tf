terraform {
  required_version = ">= 0.14"

  backend "s3" {
    endpoints = {
      s3 = "https://minio-api.abdullahainun.site" # Minio endpoint
    }
    bucket = "homelab-tf-proxmox"
    key    = "state/talos-k8s-cluster/homelab-k8s"

    region                      = "main" # Region validation will be skipped
    skip_credentials_validation = true   # Skip AWS related checks and validations
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    use_path_style              = true # Enable path-style S3 URLs (https://<HOST>/<BUCKET> https://developer.hashicorp.com/terraform/language/settings/backends/s3#use_path_style
  }
}

module "vms_proxmox" {
  source  = "../../../modules/vms_proxmox/"
  proxmox = var.proxmox
  cluster = var.cluster
  vms     = var.vms
}

module "talos_k8s" {
  depends_on = [module.vms_proxmox]
  source     = "../../../modules/talos_k8s"

  cluster = {
    name     = var.cluster.name
    endpoint = var.cluster.endpoint
  }

  nodes = { for k, vm in var.vms : k => merge(vm, {
    ip = lookup(module.vms_proxmox.qemu_ipv4_addresses, k, vm.ip)
  }) }
}

# module "init_k8s" {
#   depends_on = [module.talos_k8s]
#   source     = "./modules/init_k8s"
#   count      = (var.certificate == null) ? 0 : 1

#   providers = {
#     kubernetes = kubernetes
#   }

#   certificate = var.certificate
# }

