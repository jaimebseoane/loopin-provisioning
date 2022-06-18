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
    hosts       = list(string)
  })
  default = {
    datacenter = "Datacenter"
    hosts       = ["esxi-1.ss4.nepgroup.io", "esxi-2.ss4.nepgroup.io", "esxi-3.ss4.nepgroup.io", "esxi-4.ss4.nepgroup.io"]
  }
}

