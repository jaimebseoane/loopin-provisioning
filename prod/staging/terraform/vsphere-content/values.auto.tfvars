// vSphere Datacenter credential and access endpoint
vs_dc_access = {
  username = "CloudOwner@gve.local"
  password = "JzsehOdHS=wu9jmI"
  endpoint = "vcsa-119670.b2ed62a8.europe-west4.gve.goog"
  #  endpoint =  "10.90.0.6"
}

// vSphere configuration
vs_configuration = {
  datacenter  = "Datacenter"
  cluster     = "Cluster"
  datastore   = "vsanDatastore"
  network     = "tfc-gcve-qa-gcp-workload-segment1"
  vm_template = "ubuntu-20.04-cloud-template-vm"
}


