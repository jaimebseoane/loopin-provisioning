data "vsphere_datacenter" "datacenter" {
  name = var.vs_configuration.datacenter
}

data "vsphere_host" "hosts" {
  count         = length(var.vs_configuration.hosts)
  name          = var.vs_configuration.hosts[count.index]
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_compute_cluster" "compute_cluster" {
  name            = "cluster"
  datacenter_id   = data.vsphere_datacenter.datacenter.id
  host_system_ids = data.vsphere_host.hosts.*.id


  drs_enabled = false
  ha_enabled  = false
}
