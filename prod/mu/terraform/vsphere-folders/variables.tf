// vSphere Datacenter credential and access endpoint
// NOTE: remember to add an entry in the hosts file for the endpoint IP address if it cannot be
//       looked up via DNS

// vcenter access endpoint and credentials
variable "vs_dc_access" {
  description = "Credentials for vSphere datacenter"
  type        = object({
    username = string
    endpoint = string
  })
  default = {
    username = "CloudOwner@gve.local"
    endpoint = "vcsa-119670.b2ed62a8.europe-west4.gve.goog"
    #  endpoint =  "10.90.0.6"
  }
}

// vcenter password
variable "vs_password" {
  description = "vCenter password"
  type        = string
  sensitive   = true
}

// datacenter required configuration data sources
variable "vs_configuration" {
  description = "Overall vSphere components"
  type        = object({
    datacenter = string
  })
  default = {
    datacenter = "Datacenter"
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
    parent     = "parent"
    subfolders = ["subfolder1", "subfolder2", "subfolder3"]
  }
}
