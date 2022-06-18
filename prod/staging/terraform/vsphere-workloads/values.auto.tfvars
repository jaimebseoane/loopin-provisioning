// vSphere Datacenter credential and access endpoint
vs_dc_access = {
  username = "Administrator@ss4.nepgroup.io"
  endpoint = "vcenter-1.ss4.nepgroup.io"
  #  endpoint =  "10.90.0.6"
}

// vSphere configuration
vs_configuration = {
  datacenter  = "SS4"
  cluster     = "cluster"
  datastores  = ["STORAGE", "BOOT"]
  network     = "CLUSTER-55"
  vm_template = "vm-template"
}

// workloads variable defines the structure and specs for layering, folder naming
// and VM specs for each VM in the given layer
workloads = {
  name         = "workloads"
  ipv4_netmask = "24"
  domain       = "nepgroup.io"
  subdomain    = "ss4"
  subnet_id    = "10.4.55"
  hosts        = ["esxi-1.ss4.nepgroup.io", "esxi-2.ss4.nepgroup.io", "esxi-3.ss4.nepgroup.io"]
  layers       = {
    // layer definition:
    // <layer_name> = [
    //        <folder_name>,
    //        <hostname>,
    //        <layer subnet IP range start last octet>,
    //        <# of cpus>,
    //        <MB memory>,
    //        <GB disk>,
    // ]
    dns                  = ["dns", "bind", "130", "2", "2048", "40", "HD"]
    maestros             = ["maestros", "maestro", "100", "1", "2048", "30", "HD"]
    loadbalancers        = ["loadbalancers", "loadbalancer", "110", "2", "2048", "30", "HD"]
    databases            = ["databases", "mariadb", "120", "2", "4096", "50", "SSD"]
    monitoring_masters   = ["monitoring", "monitor-master", "30", "2", "4096", "50", "HD"]
    monitoring_workers   = ["monitoring", "monitor-worker", "35", "4", "8192", "500", "HD"]
    #    controllers_masters  = ["controllers", "rancher-master", "10", "2", "4096", "50", "HD"]
    #    controllers_workers  = ["controllers", "rancher-worker", "15", "8", "16384", "100", "HD"]
    applications_masters = ["applications", "tfc-master", "20", "2", "8192", "50", "HD"]
    applications_workers = ["applications", "tfc-worker", "25", "8", "16384", "120", "HD"]
    # testing = ["testing", "test", "70", "2", "4096", "20", "HD"]
  }
}

workloads_mon = {
  name         = "workloads"
  ipv4_netmask = "24"
  domain       = "nepgroup.io"
  subdomain    = "ss4"
  subnet_id    = "10.4.55"
  hosts        = ["esxi-4.ss4.nepgroup.io"]
  layers       = {
    loggers = ["loggers", "logger", "140", "4", "8192", "500", "HD"]
  }
}