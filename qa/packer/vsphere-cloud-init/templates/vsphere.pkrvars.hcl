/*
    DESCRIPTION: 
    VMaware vSphere variables used for all builds.
    - Variables are use by the source blocks.
*/

// vSphere Credentials
// vSphere hostname: vcsa-108047.f460a5dd.europe-west4.gve.goog
vsphere_endpoint            = "10.90.0.6"
vsphere_username            = "CloudOwner@gve.local"
vsphere_password            = "HLTOv4grYhQCkd%J"
vsphere_insecure_connection = true

// vSphere Settings
vsphere_datacenter = "Datacenter"
vsphere_cluster    = "Cluster"
vsphere_datastore  = "vsanDatastore"
vsphere_network    = "tfc-gcve-qa-gcp-workload-segment1"
//vsphere_network    = "Edge-Uplink1"
vsphere_folder     = "templates/packer/ubuntu"


// Virtual Machine Settings
vsphere_vm_version           = 19
vsphere_tools_upgrade_policy = true
vsphere_remove_cdrom         = true

// Removable Media Settings
vsphere_iso_datastore = "vsanDatastore"
vsphere_iso_path      = "/iso/ubuntu/server/20.04.4"
vsphere_iso_hash = "sha512"

// Boot and Provisioning Settings
vsphere_http_port_min    = 8000
vsphere_http_port_max    = 8099
vsphere_ip_wait_timeout  = "20m"
vsphere_shutdown_timeout = "15m"

// Template and Content Library Settings
vsphere_template_conversion = true
# vsphere_content_library_name    = "sfo-w01-lib01"
# vsphere_content_library_ovf     = true
# vsphere_content_library_destroy = true