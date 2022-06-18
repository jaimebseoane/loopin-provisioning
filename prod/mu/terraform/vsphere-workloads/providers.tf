provider "vsphere" {
  user           = var.vs_dc_access.username
  password       = var.vs_password
  vsphere_server = var.vs_dc_access.endpoint

  # if you have a self-signed cert
  allow_unverified_ssl = true
}