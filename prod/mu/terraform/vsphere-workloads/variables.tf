// -----------  vsphere server access variables  -----------------
variable "vs_dc_access" {
  description = "Credentials for vSphere datacenter"
  type        = object({
    username = string
    endpoint = string
  })
  default = {
    username = ""
    endpoint = ""
  }
}

variable "vs_password" {
  description = "vCenter password"
  type        = string
  sensitive   = true
}


// ----------- vsphere datacenter variables -----------------

variable "vs_configuration" {
  description = "Overall vSphere components"
  type        = object({
    datacenter  = string
    cluster     = string
    datastores   = list(string)
    network     = string
    vm_template = string
  })
  default = {
    datacenter  = "Datacenter"
    cluster     = "Cluster"
    datastores   = ["STORAGE", "BOOT"]
    network     = "tfc-gcve-qa-gcp-workload-segment1"
    vm_template = "ubuntu-20.04-cloud-template-vm"
  }
}

variable "workloads" {
  description = "For all dynamic settings for all VMs in a DC"
  type        = object({
    name         = string
    ipv4_netmask = string
    domain       = string
    subdomain    = string
    subnet_id    = string
    hosts        = list(string)
    layers       = map(list(string))
  })
  default = {
    name         = "workloads"
    ipv4_netmask = "24"
    domain       = "nepgroup.io"
    subdomain    = "ss4"
    subnet_id    = "10.90.8"
    hosts        = ["esxi", "esxi2", "esxi3"]
    layers       = {
      dns                  = ["dns", "bind", "130", "2", "2048", "40", "HD"]
      maestros             = ["maestros", "maestro", "100", "2", "2048", "40", "HD"]
      loadbalancers        = ["loadbalancers", "loadbalancer", "110", "2", "2048", "40", "HD"]
      databases            = ["databases", "mariadb", "120", "2", "2048", "40", "SSD"]
      monitoring_masters   = ["monitoring", "monitor-master", "30", "2", "2048", "40","HD"]
      monitoring_workers   = ["monitoring", "monitor-worker", "35", "2", "2048", "40","HD"]
      controllers_masters  = ["controllers", "rancher-master", "10", "2", "2048", "40","HD"]
      controllers_workers  = ["controllers", "rancher-worker", "15", "2", "2048", "40","HD"]
      applications_masters = ["applications", "tfc-master", "20", "2", "2048", "40","HD"]
      applications_workers = ["applications", "tfc-worker", "25", "2", "2048", "40", "HD"]
    }
  }
}

variable "workloads_mon" {
  description = "For all dynamic settings for all VMs in a DC"
  type        = object({
    name         = string
    ipv4_netmask = string
    domain       = string
    subdomain    = string
    subnet_id    = string
    hosts        = list(string)
    layers       = map(list(string))
  })
  default = null
}
