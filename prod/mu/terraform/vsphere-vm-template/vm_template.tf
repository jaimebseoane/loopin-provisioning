data "vsphere_datacenter" "datacenter" {
  name = var.vs_configuration.datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vs_configuration.datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vs_configuration.cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_host" "host" {
  name          = var.vs_configuration.host
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = var.vs_configuration.network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "template_file" "userdata" {
  template = local.userdata_template_relative_path
  vars     = {
    vm_ip_address  = local.ip_address
    vm_netmask     = var.userdata.ipv4_netmask
    vm_gateway     = local.ipv4_gateway
    vm_dns_servers = var.userdata.public_dns_server
    vm_dns_search  = join(", ", local.dns_suffix_list)
  }
}

module "folders" {
  source = "../vsphere-folders"
  vs_password = var.vs_password
  folders = var.folders
}

#resource "vsphere_folder" "template" {
#  path          = var.folder.path
#  type          = var.folder.type
#  datacenter_id = data.vsphere_datacenter.datacenter.id
#}

resource "random_uuid" "instanceid" {
}

resource "vsphere_virtual_machine" "vmFromLocalOvf" {
  depends_on       = [module.folders]
  name             = var.vm_specs.hostname
  datacenter_id    = data.vsphere_datacenter.datacenter.id
  datastore_id     = data.vsphere_datastore.datastore.id
  host_system_id   = data.vsphere_host.host.id
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  folder           = var.folders.parent

  #  wait_for_guest_net_timeout = 0
  #  wait_for_guest_ip_timeout  = 0

  num_cpus               = var.vm_specs.num_cpus
  num_cores_per_socket   = var.vm_specs.num_cores_per_socket
  cpu_hot_add_enabled    = var.vm_specs.cpu_hot_add_enabled
  cpu_hot_remove_enabled = var.vm_specs.cpu_hot_remove_enabled
  cpu_reservation        = var.vm_specs.cpu_reservation
  memory_reservation     = var.vm_specs.memory_reservation
  memory                 = var.vm_specs.memory
  memory_hot_add_enabled = var.vm_specs.memory_hot_add_enabled

  disk {
    label = var.vm_specs.disk_label
    size  = var.vm_specs.disk_size
  }

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  ovf_deploy {
    allow_unverified_ssl_cert = var.ova.allow_unverified_ssl_cert
    local_ovf_path            = var.ova.local_ovf_path
    #    remote_ovf_url            = var.ova.remote_ovf_url
    disk_provisioning         = var.ova.disk_provisioning
    ip_protocol               = var.ova.ip_protocol
    ip_allocation_policy      = var.ova.ip_allocation_policy
    ovf_network_map           = {
      "VM Network" = data.vsphere_network.network.id
    }
  }

  cdrom {
    client_device = true
  }


  vapp {
    properties = {
      "instance-id" = random_uuid.instanceid.id
      "hostname"    = var.vm_specs.hostname
      "password"    = var.vm_specs.default_password
      "user-data"   = local.userdata_encoded
    }
  }


}
