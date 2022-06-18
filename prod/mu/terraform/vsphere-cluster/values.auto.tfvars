// vSphere Datacenter credential and access endpoint
// NOTE: remember to add an entry in the hosts file for the endpoint IP address if it cannot be
//       looked up via DNS
vs_dc_access = {
  username = "Administrator@ss4.nepgroup.io"
  endpoint = "vcenter-1.ss4.nepgroup.io"
  #  endpoint =  "10.90.0.6"
}

// vSphere configuration
vs_configuration = {
  datacenter = "SS4"
  hosts      = ["esxi-1.ss4.nepgroup.io", "esxi-2.ss4.nepgroup.io", "esxi-3.ss4.nepgroup.io", "esxi-4.ss4.nepgroup.io"]
}

