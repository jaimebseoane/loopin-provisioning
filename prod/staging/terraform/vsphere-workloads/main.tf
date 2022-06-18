data "vsphere_datacenter" "dc" {
  name = var.vs_configuration.datacenter
}

#resource "vsphere_folder" "parent" {
#  path          = var.workloads.name
#  type          = "vm"
#  datacenter_id = data.vsphere_datacenter.dc.id
#}

module "vms" {
  source           = "./modules/vms"
  for_each         = var.workloads.layers
  vm_folder        = "${var.workloads.name}/${each.value[0]}"
  vm_name          = each.value[1]
  workloads        = var.workloads
  layer            = each.value
  vs_configuration = var.vs_configuration
}

module "vms_mon" {
  source           = "./modules/vms"
  vm_folder        = "${var.workloads.name}/loggers"
  vm_name          = "logger"
  workloads        = var.workloads_mon
  layer            = var.workloads_mon.layers.loggers
  vs_configuration = var.vs_configuration
}