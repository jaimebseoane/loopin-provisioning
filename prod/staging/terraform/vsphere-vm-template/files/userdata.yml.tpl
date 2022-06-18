#cloud-config

apt:
  preserve_sources_list: false
#  primary:
#    - arches: [amd64, i386]
#      uri: http://us.archive.ubuntu.com/ubuntu
#    - arches: [default]
#      uri: http://ports.ubuntu.com/ubuntu-ports

packages:
  - openssh-server
  - open-vm-tools
  - cloud-init
  - curl
  - vim
  - ca-certificates
  - gnupg
  - wget
  - python3.8
  - git

package_update: true
package_upgrade: true
package_reboot_if_required: true

locale: en_US.UTF-8

keyboard:
  layout: us

timezone: UTC

groups:
  - wheel
  - devops

users:
  - default
  - name: ansible
    primary_group: ansible
    groups:
      - devops
      - wheel
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    lock_passwd: false
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDOW+tB/3EzvQ4tGgPjrxvYzRP4sOsdbE8TKrxg7Ml1mNj+AmKPS0sizDZ2+3zcZ8EK6A0RWNN/mNZaScd2DJu942/4J+/38/iTyLwksQ7Qhn9FSES/o51f4qfzL1+sGBMvHzI9i+Bl7OG5arlnIHtnONAOjRVu5ngn+M1oBQMdHsulK8YvSHlGNm8fCOown+yhjvabUfIvUHQhzyKyngnG2hjWAoGd59/KVMOptupUJ4dZ3Pw8jXKzM6cGWctzG1LNiHFMATT5VKPiHmlU0eLXnh5Y00fy8ty/3SiFLJw8x/bXbq41dwRTZL6dxs/8vjd0B/on4aCHP+fhvA0F79q7rkindi3KSLINz0+5qMZn5qaHEF8xEWHZmHaumbmE9UNodL2yjIcG+OCdmaEzs3915VasyGu3/ErfbnnVV/H2zfvBJhMDC98P4JeQSYOH2eEzPS6u3Tqvc4hwitEqeNdde5HOmeQTnipPHZprAx84xBs3apzRgDKNtdYZPocX47EuKwNGAouAemYxQI6yZWGbrfOZJdVbFSleM+f4WuXEj8iFgJbPMw/b2t4uKdVeIoAWhEZlgfL2WVuwIGXjW2PDcGzAb662Nr/rLd7XFa1l6Cmn/XQnKWGBXEa0ByrniP6YC1KvyDbPzdYu4Kqciy8usa9XF/iPsQToT6IRV8RcMQ==
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCoFyi7Y2W+KsZjIrUXdeZSH+EAVvvZU23q3KXEn4jqDEgAzvgFfEvBeU82GRHd9HqI0Q2Va1SnuYg4CcyMlBg8QSwabuxgnhExcvDGOiKGAdBpZ+9EPQ8JXrMg3UhgkDisdamT+SXQApAocbP6+m18oxxyJ6/fbsmkK0+evFbr/iIxaBYwb2ct/N9TpnUxGVYhGGazXfPeY02cym25/quWlmyotQ1b1LZYpDJhwkiLDhLkj0fBAxxh05koJ2BVuA1OenaqhYvHpjcr+9AyBxwB/g3SE54ztvZramTK+rtD7SaIOBibOrCnS7FwceRCvixdKBlgQ6OlkkDJNPSL3//qWBzXU/Nmjf715YS/YGv56xHHHM68y+aN+DOLC88peajos0DsAcHOR60aykdCqqxrnFBACjk5G60eaGTZ7IEQAUZdh/vnVWqVrFWVOgIWuLJG5CLHApSwIL4S+P3CI0mxlfDodrV1XSrPHXFsDAgEmltUqWiMt7Da3eWVD6HdtudwjF+SJ/OpIqBtqjotW3GX901OEj+y9bMeIog7uqomHrcZIVTta3NM2cXCib/gfucfdGvSuBl8Elc8LHqmVXO1IuvGX+F0P2iZoISflqPHjIHFY1WtIG7M9DCoM8rUIuEVdiLS2QjAZ7bO31nDMhdH6JbrqDQQhJwFvP/EWanwjw== jseoane@jseoane-Virtual-Machine
  - name: root
    shell: /bin/bash
    lock_password: false
    ssh_authorized_keys:
      - ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAF8/eKIPsVSLYc9BKTmZTLJ3lCiY9rNzsVyEkNLehXXje5QFnOngXXrC3lQ05agStX8GThFUO6vqcOvgygeDpEgaAHAikfSOcvoXvi0z1aFRnxamCzLDMDHG2xS0YVe/pXF1ZzosSUoImXnhcNpXYps34Rexfgx71xj+e27JVqHVj41BQ== jseoane@work-laptop-vm
  - name: node-exporter
    shell: /sbin/nologin
    no_create_home: true

disable_root: false

ssh_pwauth: true

chpasswd:
  expire: False
  list:
    - root:$6$RST7zLke8Kn/$PyBSuIZWWJy3bwrlf/uHm3VQ80nkkUB/.ZjfIiEm/0FOjI4FWyNLkADt5uNMJL7ujQ7oZYdc7RWVJ62n844vd1

# The VM will initially come up with DHCP.  This overrides the existing netplan.
write_files:
#  - path: /etc/cloud/cloud.cfg.d/99-custom-networking.cfg
#    permissions: 0644
#    content: |
#      network: {config: disabled}
  - path: /etc/multipath.conf
    permissions: '0644'
    content: |
      blacklist {
        device {
          vendor "VMware"
          product "Virtual disk"
        }
      }
    append: true

  - path: /etc/netplan/50-cloud-init.yaml
    content: |
      network:
        version: 2
        ethernets:
          ens192:
            wakeonlan: true
            dhcp4: false
            dhcp6: false
            addresses:
              - ${vm_ip_address}/${vm_netmask}
            gateway4: ${vm_gateway}
            nameservers:
              addresses: [${vm_dns_servers}]
              search: [${vm_dns_search}]

  - path: /etc/systemd/system/node-exporter.service
    permissions: '0755'
    content: |
      [Unit]
      Description=Node Exporter Version 1.3.1
      After=network-online.target
      [Service]
      User=node-exporter
      Group=node-exporter
      Type=simple
      ExecStart=/usr/local/bin/node_exporter --collector.textfile.directory=/etc/prometheus/tmp
      [Install]
      WantedBy=multi-user.target

  - path: /etc/modprobe.d/blacklist-floppy.conf
    content: |
      blacklist floppy

  - path: /usr/local/bin/cron_node_exporter_metric.sh
    permissions: '0755'
    content: |
      #!/bin/bash

      # Display Help
      Help() {
          echo
          echo "write-node-exporter-metric"
          echo "##########################"
          echo
          echo "Description: Write node-exporter metric."
          echo "Syntax: write-node-exporter-metric [-n|-c|-v|help]"
          echo "Example: write-node-exporter-metric -n cron_job -c 'Renew certs for proxy01' -v 0"
          echo "options:"
          echo "  -n    Reference of custom metric type. Defaults to "cron_job""
          echo "  -c    Code for metric value."
          echo "  -v    Value of metric."
          echo "  help  Show write-node-exporter-metric help."
          echo
      }

      # Show help and exit
        if [[ $1 == "help" ]]; then
            Help
            exit
        fi

        # Process params
        while getopts ":n :c: :v:" opt; do
          case $opt in
            n) TYPE="$OPTARG"
            ;;
            c) CODE="$OPTARG"
            ;;
            v) VALUE="$OPTARG"
            ;;
            \?) echo "Invalid option -$OPTARG" >&2
            Help
            exit;;
          esac
        done

        # Fallback to environment vars and default values
        : $\{TYPE:="cron_job"\}

        [[ -z "$CODE" ]] && { echo "Parameter -c|code is empty" ; exit 1; }
        [[ -z "$VALUE" ]] && { echo "Parameter -v|value is empty" ; exit 1; }

        if [ "$TYPE" == "cron_job" ]; then
            echo "Write metric node_cron_job_exit_code for code \"$CODE\" with value $VALUE."
            ID=$(echo $CODE | shasum | cut -c1-5)

            cat << EOF >> /etc/prometheus/tmp/node_cron_job_exit_code.$ID.prom.$$
        # HELP node_cron_job_exit_code Last exit code of cron job.
        # TYPE node_cron_job_exit_code counter
        node_cron_job_exit_code{code="$CODE"} $VALUE
        EOF
            mv /etc/prometheus/tmp/node_cron_job_exit_code.$ID.prom.$$ /etc/prometheus/tmp/node_cron_job_exit_code.$ID.prom
        fi

runcmd:
  - export DEBIAN_FRONTEND=noninteractive
  # activate network configuration
  - echo "reconfiguring network"
  - netplan generate
  - netplan apply
#  - rm /etc/netplan/50-cloud-init.yaml
  # update packages
  - apt update
  - apt upgrade -y
  - apt autoremove
  # download, install and configure node-exporter
  - mkdir -p /etc/prometheus/tmp/
  - curl -Lo /tmp/node_exporter-1.3.1.linux-amd64.tar.gz https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz
  - cd /
  - tar -zxvf /tmp/node_exporter-1.3.1.linux-amd64.tar.gz
  - mv /node_exporter-1.3.1.linux-amd64/node_exporter /usr/local/bin/
  - chmod 755 /usr/local/bin/node_exporter
  - rm -rf /node_exporter*
  - chown -R node-exporter:node-exporter /etc/prometheus/tmp/
  # configure log compression and daily rotation
  - sed -i "s|^#compress|compress|g" /etc/logrotate.conf
  - sed -i "s|^weekly|daily|g" /etc/logrotate.conf
  # enable ssh password authentication
  - sed -i "s|^PermitRootLogin prohibit-password|PermitRootLogin yes|g" /etc/ssh/sshd_config
  - sed -i "s|^PasswordAuthentication no|PasswordAuthentication yes|g" /etc/ssh/sshd_config
  # add %wheel group to sudoers
  - echo JXdoZWVsIEFMTD0oQUxMKSBOT1BBU1NXRDogQUxMCg== | base64 -d | tee -a /etc/sudoers
  # restart sshd and node-exporter services
  - systemctl restart sshd
  - systemctl enable --now node-exporter
  # disable floppy
  - echo "disabling floppy"
  - rmmod floppy
  - dpkg-reconfigure initramfs-tools
  # update kernel
  - update-initramfs -u
  - apt install -y ntp ifupdown mmv whois traceroute nmap apt-transport-https htop net-tools python3-pip sysstat monit pwgen ngrep fonts-powerline powerline-shell
  # enable ntp service
  - sed -i "s|^pool 0.ubuntu|pool 0.europe|g" /etc/ntp.conf
  - sed -i "s|^pool 1.ubuntu|pool 1.europe|g" /etc/ntp.conf
  - sed -i "s|^pool 2.ubuntu|pool 2.europe|g" /etc/ntp.conf
  - sed -i "s|^pool 3.ubuntu|pool 3.europe|g" /etc/ntp.conf
  - sed -i "/127.0.0.1 localhost/a 127.0.0.1 ntp.local" /etc/hosts
  - echo "server NTP-server-host prefer iburst" >> /etc/ntp.conf
  - systemctl restart ntp

final_message: |
  cloud-init has finished
  version: $version
  timestamp: $timestamp
  datasource: $datasource
  uptime: $uptime

power_state:
  delay: 'now'
  mode: reboot
  message: 'Finishing up! Rebooting'