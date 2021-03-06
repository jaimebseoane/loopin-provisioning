// vSphere Datacenter credential and access endpoint
// NOTE: remember to add an entry in the hosts file for the endpoint IP address if it cannot be
//       looked up via DNS
vs_dc_access = {
  username = "CloudOwner@gve.local"
  endpoint = "vcsa-119670.b2ed62a8.europe-west4.gve.goog"
  #  endpoint =  "10.90.0.6"
}

// vSphere configuration
vs_configuration = {
  datacenter = "Datacenter"
  cluster    = "Cluster"
  datastore  = "vsanDatastore"
  network    = "tfc-gcve-qa-gcp-workload-segment1"
  host       = "esxi-119665.b2ed62a8.europe-west4.gve.goog"
}

// Location for user-data file
userdata_template = {
  filename      = "userdata.yml.tpl"
  relative_path = "files"    // from module root directory
}

vm_specs = {
  hostname               = "vm-template"
  default_password       = "RANDOM"
  network_type           = null
  num_cpus               = 2
  num_cores_per_socket   = 1
  cpu_reservation        = null
  cpu_hot_add_enabled    = null
  cpu_hot_remove_enabled = null
  memory                 = 4096
  memory_reservation     = null
  memory_hot_add_enabled = null
  disk_label             = "hard disk 1"
  disk_size              = 10
}

userdata = {
  name              = "userdata"
  ipv4_netmask      = "24"
  public_dns_server = "8.8.8.8"
  subnet_id         = "10.90.8"
  domain            = "nepgroup.io"
  subdomain         = "ss4"
}


