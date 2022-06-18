/*
    DESCRIPTION: 
    Ubuntu Server 20.04 LTS  variables used by the Packer Plugin for VMware vSphere (vsphere-iso).
*/

// Guest Operating System Metadata
vm_guest_os_language = "en_US"
vm_guest_os_keyboard = "us"
vm_guest_os_timezone = "UTC"
vm_guest_os_family   = "linux"
vm_guest_os_vendor   = "ubuntu"
vm_guest_os_member   = "server"
vm_guest_os_version  = "20-04-lts"

// Virtual Machine Guest Operating System Setting
vm_guest_os_type = "ubuntu64Guest"

// Virtual Machine Hardware Settings
vm_firmware              = "efi"
vm_cdrom_type            = "sata"
vm_cpu_sockets           = 2
vm_cpu_cores             = 1
vm_cpu_hot_add           = false
vm_mem_size              = 2048
vm_mem_hot_add           = false
vm_disk_size             = 40960
vm_disk_controller_type  = ["pvscsi"]
vm_disk_thin_provisioned = true
vm_network_card          = "vmxnet3"

// Removable Media Settings
iso_file     = "ubuntu-20.04.4-live-server-amd64.iso"
iso_checksum = "24a03228ef99e65f892cbdeb93768e6ad50d2ceb1e7b94073ce4940c4b45760c156d54d20537f6a27df53b43f48566590a3e418611c7bdf749905d6aaa164419"
iso_urls     = "https://releases.ubuntu.com/20.04/ubuntu-20.04.3-live-server-amd64.iso"

// Boot Settings
vm_boot_order = "disk,cdrom"
vm_boot_wait  = "5s"

// Communicator Settings
// communicator_host      = "34.147.91.9"
communicator_port      = 22
communicator_timeout   = "30m"
ssh_handshake_attempts = "20"

// Provisioner Settings
scripts = ["./scripts/ubuntu/20/ubuntu-20-cloud-init.sh"]

inline = []