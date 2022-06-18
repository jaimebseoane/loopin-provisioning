// -----------  vsphere server access variables  -----------------
variable "vs_dc_access" {
  description = "Credentials for vSphere datacenter"
  type        = object({
    username = string
    password = string
    endpoint = string
  })
  default = {
    username = ""
    password = ""
    endpoint = ""
  }
}

// ----------- vsphere datacenter variables -----------------

variable "vs_configuration" {
  description = "Overall vSphere components"
  type        = object({
    datacenter  = string
    cluster     = string
    datastore   = string
    network     = string
    vm_template = string
  })
  default = {
    datacenter  = "Datacenter"
    cluster     = "Cluster"
    datastore   = "vsanDatastore"
    network     = "tfc-gcve-qa-gcp-workload-segment1"
    vm_template = "ubuntu-20.04-cloud-template-vm"
  }
}

variable "content_upload" {
  description = "OVF file to upload to content library settings"
  type        = map(string)
  default     = {
    name        = "focal-server-cloudimg-amd64"
    description = "Ubuntu server Focal cloud image 20.04"
    type        = "ovf"
    file_url    = "/home/jseoane/Downloads/focal-server-cloudimg-amd64.ova"
  }
}

