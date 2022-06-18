// module output variables and displayed outputs

output "vm_hostname" {
  value = var.vm_specs.hostname
}

output "vm_ip" {
  value = local.ip_address
}

output "vm_number_cpus" {
  value = var.vm_specs.num_cpus
}

output "vm_memory" {
  value = var.vm_specs.memory
}

output "vm_disk_size" {
  value = var.vm_specs.disk_size
}

output "vm_primary_dns" {
  value = var.userdata.public_dns_server
}

output "folder" {
  value = var.folder.path
}

output "vm_uuid" {
  value = vsphere_virtual_machine.vmFromLocalOvf.uuid
}

output "guest_ip_address" {
  value = vsphere_virtual_machine.vmFromLocalOvf.guest_ip_addresses
}

