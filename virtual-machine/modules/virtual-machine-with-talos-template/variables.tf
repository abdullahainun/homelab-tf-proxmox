variable "s3_access_key" {
  description = "The access key for the s3 or minio"
  default     = ""
  type        = string
}

variable "s3_secret_key" {
  description = "The secret key for the s3 or minio"
  default     = ""
  type        = string
}

variable "pve_username" {
  description = "The username for the proxmox virtual environment"
  default     = ""
  type        = string
}

variable "pve_password" {
  description = "The password for the proxmox virtual environment"
  default     = ""
  type        = string
}
