data "vsphere_datacenter" "dc" {
  name = var.vs_configuration.datacenter
}

data "vsphere_datastore" "datastore" {
  count         = local.vm_count_per_layer
  name          = var.layer[6] == "HD" ? format("%s0%s", var.vs_configuration.datastores[0], substr(var.workloads.hosts[count.index], 5, 1) ) : format("%s0%s", var.vs_configuration.datastores[1], substr(var.workloads.hosts[count.index], 5, 1) )
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vs_configuration.cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vs_configuration.network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.vs_configuration.vm_template
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_host" "host" {
  count         = local.vm_count_per_layer
  name          = var.workloads.hosts[count.index]
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_folder" "layers" {
  path          = var.vm_folder
  type          = "vm"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "template_file" "userdata" {
  count = local.vm_count_per_layer
  template = local.userdata_template_relative_path
  vars     = {
    # vm_ip_address  = "${var.workloads.subnet_id}.70"
    vm_ip_address  = "${var.workloads.subnet_id}.${tonumber(var.layer[2]) + count.index}"
    vm_netmask     = var.workloads.ipv4_netmask
    vm_gateway     = local.ipv4_gateway
    vm_dns_servers = join(", ", local.dns_server_list)
    vm_dns_search  = join(", ", local.dns_suffix_list)
  }
}

resource "random_uuid" "instanceid" {
}

resource "vsphere_virtual_machine" "vm" {
#  depends_on       = [vsphere_folder.layers]
  count            = local.vm_count_per_layer
  name             = "${var.vm_name}0${count.index + 1}"
  datastore_id     = data.vsphere_datastore.datastore[count.index].id
  folder           = var.vm_folder
  resource_pool_id = data.vsphere_host.host[count.index].resource_pool_id
  host_system_id   = data.vsphere_host.host[count.index].id


  num_cpus               = var.layer[3]
  num_cores_per_socket   = var.vm_specs.num_cores_per_socket
  cpu_hot_add_enabled    = var.vm_specs.cpu_hot_add_enabled
  cpu_hot_remove_enabled = var.vm_specs.cpu_hot_remove_enabled
  cpu_reservation        = var.vm_specs.cpu_reservation
  memory_reservation     = var.vm_specs.memory_reservation
  memory                 = var.layer[4]
  memory_hot_add_enabled = var.vm_specs.memory_hot_add_enabled

  guest_id         = data.vsphere_virtual_machine.template.guest_id
  scsi_type        = var.vm_specs.disk_scsi_type != "" ? var.vm_specs.disk_scsi_type : data.vsphere_virtual_machine.template.scsi_type
  enable_disk_uuid = var.vm_specs.disk_uuid_enabled

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = var.network_type != null ? var.network_type : data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  # Template disks
  dynamic "disk" {
    for_each = data.vsphere_virtual_machine.template.disks
    iterator = template_disks
    content {
      label            = "disk${template_disks.key}"
      #      size  = var.disk_sizes != null ? var.disk_sizes[template_disks.key] : data.vsphere_virtual_machine.template.disks[
      #      template_disks.key
      #      ].size
      size             = var.layer[5]
      thin_provisioned = var.vm_specs.disk_thin_provisioned ? var.vm_specs.disk_thin_provisioned : data.vsphere_virtual_machine.template.disks[
      template_disks.key
      ].thin_provisioned
      eagerly_scrub = var.vm_specs.disk_eagerly_scrub ? var.vm_specs.disk_eagerly_scrub : data.vsphere_virtual_machine.template.disks[template_disks.key].eagerly_scrub
    }
  }

  # Additional disks
  dynamic "disk" {
    for_each = var.vm_specs.disk_additionals
    iterator = additional_disks
    content {
      label            = additional_disks.key
      unit_number      = index(keys(var.vm_specs.disk_additionals), additional_disks.key) + local.template_disk_count
      size             = lookup(additional_disks.value, "size_gb", null)
      thin_provisioned = lookup(additional_disks.value, "thin_provisioned", "true")
      eagerly_scrub    = lookup(additional_disks.value, "eagerly_scrub", "false")
      datastore_id     = lookup(additional_disks.value, "datastore_id", null)
    }
  }

  cdrom {
    client_device = true
  }

  #  clone {
  #    template_uuid = data.vsphere_virtual_machine.template.id
  #    customize {
  #      network_interface {
  ##        ipv4_address = "${var.workloads.subnet_id}.${tonumber(var.layer[2]) + count.index}"
  ##        ipv4_netmask = var.workloads.ipv4_netmask
  #        ipv4_address = "10.4.55.10"
  #        ipv4_netmask = "24"
  #      }
  ##      ipv4_gateway    = local.ipv4_gateway
  ##      dns_server_list = local.dns_server_list
  ##      dns_suffix_list = local.dns_suffix_list
  #      ipv4_gateway = "10.4.55.1"
  #      dns_server_list = ["8.8.8.8"]
  #      dns_suffix_list = ["ss4.nepgroup.io"]
  #      linux_options {
  ##        domain    = "${var.workloads.subdomain}.${var.workloads.domain}"
  ##        host_name = "${var.vm_name}0${count.index + 1}"
  #        domain = "ss4.nepgroup.io"
  #        host_name = "workload"
  #      }
  #    }
  #
  #  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }

  vapp {
    properties = {
      "instance-id" = random_uuid.instanceid.id
      "hostname"    = "${var.vm_name}0${count.index + 1}"
      "password"    = var.vm_specs.default_password
      "user-data"   = base64encode(data.template_file.userdata[count.index].rendered)
    }
  }
}