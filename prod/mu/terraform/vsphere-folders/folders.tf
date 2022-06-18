// data and resources definitions

// info about the datacenter
data "vsphere_datacenter" "dc" {
  name = var.vs_configuration.datacenter
}

// create a parent vm folder int he datacenter
resource "vsphere_folder" "parent" {
  path          = var.folders.parent
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}

// create subfolders under the parent foldor in the datacenter
resource "vsphere_folder" "subfolders" {
  for_each      = toset(var.folders.subfolders)
  path          = "${vsphere_folder.parent.path}/${each.value}"
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}