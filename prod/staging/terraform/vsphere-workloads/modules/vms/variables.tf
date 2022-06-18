variable "vs_configuration" {
  description = "Overall vSphere components"
  type        = object({
    datacenter  = string
    cluster     = string
    datastores   = list(string)
    network     = string
    vm_template = string
  })
  default = null
}

variable "network_type" {
  description = "The network type for each network interface."
  type        = string
  default     = null
}

# vm variables

variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
}

variable "vm_folder" {
  description = "The name of the folder for this virtual machine."
  type        = string
}

variable "vm_specs" {
  description = "Overall vSphere components"
  type        = object({
    network_type           = string
    default_password       = string
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
    disk_scsi_type         = string
    disk_uuid_enabled      = bool
    disk_thin_provisioned  = bool
    disk_eagerly_scrub     = bool
    disk_sizes             = list(number)
    disk_additionals       = map(map(string))
  })
  default = {
    network_type           = null
    default_password       = "123"
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
    disk_scsi_type         = ""
    disk_uuid_enabled      = true
    disk_thin_provisioned  = true
    disk_eagerly_scrub     = false
    disk_sizes             = null
    disk_additionals       = {}
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
}

variable "layer" {
  description = "Indicates the current layer being provisioned"
  type        = list(string)
}

variable "userdata_template" {
  description = "Name and location of the userdata template file to be used in the vApp properties"
  type        = map(string)
  default     = {
    filename      = "userdata.yml.tpl"
    relative_path = "files"
  }
}

variable "userdata" {
  description = "For all dynamic settings for all VMs in a DC"
  type        = object({
    name         = string
    ipv4_netmask = string
    subnet_id    = string
    domain       = string
    subdomain    = string
  })
  default = {
    name         = "userdata"
    ipv4_netmask = "24"
    subnet_id    = "10.4.50"
    domain       = "nepgroup.io"
    subdomain    = "ss4"
  }
}

