#cloud-config

package_update: true
package_upgrade: true

apt:
  conf: | # APT config
    APT {
      Get {
        Assume-Yes "true";
        Fix-Broken "true";
      };
    };


# The VM will initially come up with DHCP.  This overrides the existing netplan.
write_files:
  - path: /etc/netplan/50-cloud-init.yaml
    content: |
      network:
        version: 2
        ethernets:
          ens192:
            wakeonlan: true
            dhcp4: false
            addresses:
              - ${vm_ip_address}/${vm_netmask}
            gateway4: ${vm_gateway}
            nameservers:
              addresses: [${vm_dns_servers}]
              search: [${vm_dns_search}]

runcmd:
  - export DEBIAN_FRONTEND=noninteractive
  - echo "reconfiguring network"
  - netplan apply
