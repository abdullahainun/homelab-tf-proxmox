proxmox = {
  endpoint = "https://pve.abdullahainun.site/"
  insecure = true
}

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
  },
  "worker-1" = {
    host_node      = "pve1"
    machine_type   = "worker"
    ip             = "10.10.10.21"
    cpu            = 2
    ram_dedicated  = 4096
    os_disk_size   = 10
    data_disk_size = 30
    datastore_id   = "local-lvm"
  }
}
