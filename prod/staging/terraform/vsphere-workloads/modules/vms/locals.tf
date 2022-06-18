locals {
  template_disk_count = length(data.vsphere_virtual_machine.template.disks)
  vm_count_per_layer  = length(var.workloads.hosts)

  userdata_template_relative_path = file("${path.module}/${var.userdata_template.relative_path}/${var.userdata_template.filename}")

  ipv4_gateway    = "${var.workloads.subnet_id}.1"
  dns_suffix_list = ["${var.workloads.subdomain}.${var.workloads.domain}"]
  dns_server_list = ["${var.workloads.subnet_id}.200"]
}

