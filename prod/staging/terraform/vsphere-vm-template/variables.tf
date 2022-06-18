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
    datacenter = string
    cluster    = string
    datastore  = string
    network    = string
    host       = string
  })
  default = {
    datacenter = "Datacenter"
    cluster    = "Cluster"
    datastore  = "vsanDatastore"
    network    = "tfc-gcve-qa-gcp-workload-segment1"
    host       = "esxi-119665.b2ed62a8.europe-west4.gve.goog"
  }
}

// datacenter folders to be created
variable "folders" {
  description = "folder structure for datacenter"
  type        = object({
    parent     = string
    subfolders = list(string)
  })
  default = {
    parent     = "templates"
    subfolders = []
  }
}

variable "userdata_template" {
  description = "Name and location of the userdata template file to be used in the vApp properties"
  type        = map(string)
  default     = {
    filename      = "userdata.yml.tpl"
    relative_path = "files"
  }
}

variable "vm_specs" {
  description = "Overall vSphere components"
  type        = object({
    hostname               = string
    default_password       = string
    network_type           = string
    num_cpus               = number
    num_cores_per_socket   = number
    cpu_reservation        = number
    cpu_hot_add_enabled    = bool
    cpu_hot_remove_enabled = bool
    memory                 = number
    memory_reservation     = number
    memory_hot_add_enabled = bool
    disk_label             = string
    disk_size              = number
  })
  default = {
    hostname               = "vm-template"
    default_password       = "RANDOM"
    network_type           = null
    num_cpus               = 2
    num_cores_per_socket   = 1
    cpu_reservation        = null
    cpu_hot_add_enabled    = null
    cpu_hot_remove_enabled = null
    memory                 = 4096
    memory_reservation     = null
    memory_hot_add_enabled = null
    disk_label             = "hard disk 1"
    disk_size              = 10
  }
}

variable "userdata" {
  description = "For all dynamic settings for all VMs in a DC"
  type        = object({
    name              = string
    ipv4_netmask      = string
    public_dns_server = string
    subnet_id         = string
    domain            = string
    subdomain         = string
  })
  default = {
    name              = "userdata"
    ipv4_netmask      = "24"
    public_dns_server = "8.8.8.8"
    subnet_id         = "10.90.8"
    domain            = "nepgroup.io"
    subdomain         = "ss4"
  }
}

variable "ova" {
  type = object({
    allow_unverified_ssl_cert = bool
    local_ovf_path            = string
    remote_ovf_url            = string
    disk_provisioning         = string
    ip_protocol               = string
    ip_allocation_policy      = string
  })
  default = {
    allow_unverified_ssl_cert = false
    local_ovf_path            = "/home/jseoane/Downloads/focal-server-cloudimg-amd64.ova"
    remote_ovf_url            = "https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.ova"
    disk_provisioning         = "thin"
    ip_protocol               = "IPV4"
    ip_allocation_policy      = "STATIC_MANUAL"
  }
}

variable "folder" {
  description = "Folder for the template VM"
  type        = map(string)
  default     = {
    path = "template"
    type = "vm"
  }
}
