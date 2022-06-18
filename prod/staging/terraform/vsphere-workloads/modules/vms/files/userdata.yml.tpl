#cloud-config

write_files:
  - path: /etc/netplan/50-cloud-init.yaml
    permissions: '0644'
    content: |
      network:
        version: 2
        ethernets:
          ens192:
            dhcp4: false
            dhcp6: false
            addresses:
              - ${vm_ip_address}/${vm_netmask}
            gateway4: ${vm_gateway}
            nameservers:
              addresses: [${vm_dns_servers}]
              search: [${vm_dns_search}]

cloud_config_modules:
  - runcmd

cloud_final_modules:
  - scripts-user

runcmd:
  - netplan generate
  - netplan apply