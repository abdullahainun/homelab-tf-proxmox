cluster = {
  name     = "homelab-k8s"
  gateway  = "10.10.10.1"
  cidr     = 24
  vlan_id  = "200"
  endpoint = "10.10.10.10"
  file_id  = "nfs-repo:iso/homelab-k8s-talos-v1.9.4-nocloud-amd64.img"
}

vms = {
  "cp-1" = {
    host_node      = "pve1"
    machine_type   = "controlplane"
    ip             = "10.10.10.10"
    cpu            = 4
    ram_dedicated  = 8000
    os_disk_size   = 50
    data_disk_size = 100
    datastore_id   = "local-lvm"
  },
  "worker-1" = {
    host_node      = "pve2"
    machine_type   = "worker"
    ip             = "10.10.10.21"
    cpu            = 4
    ram_dedicated  = 8000
    os_disk_size   = 50
    data_disk_size = 100
    datastore_id   = "local-lvm"
  },
  "worker-2" = {
    host_node      = "pve3"
    machine_type   = "worker"
    ip             = "10.10.10.22"
    cpu            = 4
    ram_dedicated  = 8000
    os_disk_size   = 50
    data_disk_size = 100
    datastore_id   = "local-lvm"
  }
}
