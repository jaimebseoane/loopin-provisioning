locals {
  vm_count_per_layer = tostring(length(var.workloads.hosts))
}

