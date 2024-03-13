***Help:***
```
  usage: netplanner [-h] [-V] [-v] [-l] [-i INTERFACE] [-g] [-r] [-c] [--backup]
                  [--restore RESTORE] [-s]
  A tool for managing basic Netplan configurations for Ubuntu

  optional arguments:
    -h, --help            show this help message and exit
    -V, --version         Show version information and exit
    -v, --view            View network configuration(s)
    -l, --list            List available network interfaces
    -i INTERFACE, --interface INTERFACE
                          Specific Interface
    -g, --generate        Generate new netplan configuration
    -r, --remove          Remove netplan configuration for a specific interface
    -c, --clean           Clean netplan configurations
    --backup              Backup netplan configurations
    --restore RESTORE     Restore netplan configurations from tgz backup
    -s, --sanity          Perform sanity-check on netplan configurations
```

**Examples:**

***View Interface Configuration***

  $ `sudo ./netplanner -v`
  ```
  Netplan Configuration: /etc/netplan/eno1.yaml
  network:
    version: 2
    ethernets:
      eno1:
        dhcp4: no
        dhcp6: no
        addresses: [192.168.122.11/24]
        gateway4: 192.168.122.1
        nameservers:
          addresses: [192.168.122.1, 10.66.67.1]
        mtu: 1400
  Netplan Configuration: /etc/netplan/eno2.yaml
  network:
    version: 2
    ethernets:
      eno2:
        dhcp4: no
        dhcp6: no
        addresses: [192.168.254.253/30]
   ```   

***Netplan Configuration Backup:***  

  $ `sudo ./netplanner --backup`
  ```
  Backing up netplan configuration files
  Backing up /etc/netplan to /var/log/netplan-backup-2024-03-12_22-13-16.tgz
  Backup created: /var/log/netplan-backup-2024-03-12_22-13-16.tgz
  To restore this configuration, run: sudo ./netplanner --restore /var/log/netplan-backup-2024-03-12_22-13-16.tgz
  ```

***Netplan Configuration Restore:***

  $ `sudo ./netplanner --restore /var/log/netplan-backup-2024-03-12_22-13-16.tgz`
  ```
  Restoring netplan configuration files
  Attempting to restore files from backup /var/log/netplan-backup-2024-03-12_22-13-16.tgz:
  Backup restored: /var/log/netplan-backup-2024-03-12_22-13-16.tgz
  ```

***Static IP Address Configuration:***

  $ `sudo ./netplanner`
  ```
  Top level function not selected.
  Available interfaces: eno1, eno2, br-777129ecb039
  Enter the network interface (e.g., eth0): eno1
  2: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1400 qdisc fq_codel state UP group default qlen 1000
      link/ether 12:34:56:78:9a:bc brd ff:ff:ff:ff:ff:ff
      inet 192.168.122.11/24 brd 192.168.122.255 scope global eno1
         valid_lft forever preferred_lft forever
  
  Choose configuration type (dhcp/static/none): static
  Enter MTU (hit enter for default): 
  Enter the IP address (e.g., 192.168.1.10): 192.168.122.11
  Common masks & CIDR notation:
      CIDR: Mask:
      16    255.255.0.0 *
      17    255.255.128.0
      18    255.255.192.0
      19    255.255.224.0
      20    255.255.240.0
      21    255.255.248.0
      22    255.255.252.0
      23    255.255.254.0
      24    255.255.255.0 ***
      25    255.255.255.128
      26    255.255.255.192
      27    255.255.255.224
      28    255.255.255.240
      29    255.255.255.248
      30    255.255.255.252
      
  Enter the network prefix length (/24, 24): /24
  Enter the gateway address (blank for local connection only): 192.168.122.1
  Enter DNS addresses (comma-separated, hit enter if none or done): 192.168.122.1,4.2.2.1
  Current valid DNS IPs: ['192.168.122.1', '4.2.2.1']
  Generated configuration:
  
  network:
    version: 2
    ethernets:
      eno1:
        dhcp4: no
        dhcp6: no
        addresses: [192.168.122.11/24]
        gateway4: 192.168.122.1
        nameservers:
          addresses: [192.168.122.1, 4.2.2.1]
        
  
  Apply this configuration? (yes/NO): yes
  Attempting to remove any unnecessary netplan configuration files:
  Removed configuration for eno1 from /etc/netplan/eno1.yaml
  No existing configuration found for eno1. Proceeding with new configuration.
  Do you want to keep these settings?
  
  
  Press ENTER before the timeout to accept the new configuration
  
  
  Changes will revert in 119 seconds
  Configuration accepted.
  Configuration applied for eno1.
  ```

***Static IP Address for Local Network Only:***

  $ `sudo ./netplanner`
  ```
  Top level function not selected.
  Available interfaces: eno1, eno2, br-777129ecb039
  Enter the network interface (e.g., eth0): eno2
  3: eno2: <BROADCAST,MULTICAST,PROMISC,UP,LOWER_UP> mtu 9000 qdisc fq_codel state UP group default qlen 1000
      link/ether 12:34:56:78:9a:ef brd ff:ff:ff:ff:ff:ff
  
  Choose configuration type (dhcp/static/none): static
  Enter MTU (hit enter for default): 1500
  Enter the IP address (e.g., 192.168.1.10): 192.168.254.254
  Common masks & CIDR notation:
      CIDR: Mask:
      16    255.255.0.0 *
      17    255.255.128.0
      18    255.255.192.0
      19    255.255.224.0
      20    255.255.240.0
      21    255.255.248.0
      22    255.255.252.0
      23    255.255.254.0
      24    255.255.255.0 ***
      25    255.255.255.128
      26    255.255.255.192
      27    255.255.255.224
      28    255.255.255.240
      29    255.255.255.248
      30    255.255.255.252
      
  Enter the network prefix length (/24, 24): 30
  Enter the gateway address (blank for local connection only): 
  No gateway defined
  Generated configuration:
  
  network:
    version: 2
    ethernets:
      eno2:
        dhcp4: no
        dhcp6: no
        addresses: [192.168.254.254/30]
  
  Apply this configuration? (yes/NO): yes
  Attempting to remove any unnecessary netplan configuration files:
  Removed configuration for eno2 from /etc/netplan/eno2.yaml
  No existing configuration found for eno2. Proceeding with new configuration.
  Do you want to keep these settings?
  
  
  Press ENTER before the timeout to accept the new configuration
  
  
  Changes will revert in 119 seconds
  Configuration accepted.
  Configuration applied for eno2.
  ```

***DHCP IP Address Configuration:***

  $ `sudo ./netplanner`
  ```
  Top level function not selected.
  Available interfaces: eno1, eno2, br-777129ecb039
  Enter the network interface (e.g., eth0): eno2
  3: eno2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
      link/ether 12:34:56:78:9a:bc brd ff:ff:ff:ff:ff:ff
      inet 192.168.254.253/30 brd 192.168.254.255 scope global eno2
         valid_lft forever preferred_lft forever
  
  Choose configuration type (dhcp/static/none): dhcp
  Enter MTU (hit enter for default): 
  Generated configuration:
  
  network:
    version: 2
    ethernets:
      eno2:
        dhcp4: yes
        dhcp6: no
        
  
  Apply this configuration? (yes/NO): yes
  Attempting to remove any unnecessary netplan configuration files:
  Removed configuration for eno2 from /etc/netplan/eno2.yaml
  No existing configuration found for eno2. Proceeding with new configuration.
  Do you want to keep these settings?
  
  
  Press ENTER before the timeout to accept the new configuration
  
  
  Changes will revert in 119 seconds
  Configuration accepted.
  Configuration applied for eno2.
  ```

***No IP address (network monitoring):***

  $ `sudo ./netplanner`
  ```
  Top level function not selected.
  Available interfaces: eno1, eno2, br-777129ecb039
  Enter the network interface (e.g., eth0): eno2
  3: eno2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
      link/ether 12:34:56:78:9a:bc brd ff:ff:ff:ff:ff:ff
  
  Choose configuration type (dhcp/static/none): none
  Enter MTU (hit enter for default): 9000
  Generated configuration:
  
  network:
    version: 2
    ethernets:
      eno2:
        dhcp4: no
        dhcp6: no
        mtu: 9000
  
  Apply this configuration? (yes/NO): yes
  Attempting to remove any unnecessary netplan configuration files:
  Removed configuration for eno2 from /etc/netplan/eno2.yaml
  No existing configuration found for eno2. Proceeding with new configuration.
  Do you want to keep these settings?
  
  
  Press ENTER before the timeout to accept the new configuration
  
  
  Changes will revert in 119 seconds
  Configuration accepted.
  Enable promiscuous mode for interface eno2? (yes/NO): yes
  Promiscuous mode enabled for interface: eno2
  (Please note that promiscuous mode is not persistent across many netplan-enabled systems.)
  Configuration applied for eno2.
  ```

***Remove All Netplan Configurations:***

  $ `sudo ./netplanner --remove`
  ```
  
  ```

***Clean Duplicate Interface Configuration:***

  $ `sudo ./netplanner --clean`
  ```
  Backing up /etc/netplan to /var/log/netplan-backup-2024-03-12_23-19-59.tgz
  Backup created: /var/log/netplan-backup-2024-03-12_23-19-59.tgz
  To restore this configuration, run: sudo ./netplanner --restore /var/log/netplan-backup-2024-03-12_23-19-59.tgz
  
  Sanity check performed for interface: eno1
  Sanity check performed for interface: eno2
  
  Searching for configuration conflict(s) for interface eno1: 
      duplicate.yaml
      eno1.yaml
  
  Found conflicting configuration for interface eno1
  Would you like to view the contents of the files? (yes/NO): yes
  Viewing configuration files for eno1:
      1. /etc/netplan/eno1.yaml
  Netplan Configuration: /etc/netplan/eno1.yaml
  network:
    version: 2
    ethernets:
      eno1:
        dhcp4: no
        dhcp6: no
        addresses: [192.168.122.11/24]
        gateway4: 192.168.122.1
        nameservers:
          addresses: [192.168.122.1, 4.2.2.1]
        
      2. /etc/netplan/duplicate.yaml
  Netplan Configuration: /etc/netplan/duplicate.yaml
  network:
    version: 2
    ethernets:
      eno1:
        dhcp4: no
        dhcp6: no
        addresses: [192.168.122.11/24]
        gateway4: 192.168.122.1
        nameservers:
          addresses: [192.168.122.1, 4.2.2.1]
      eno2:
        dhcp4: no
        dhcp6: no
        addresses: [192.168.254.254/30]
  (m) Manually address configuration file conflicts (exits)
  (c) Create new network interface configuration file
  (d) Delete network interface configuration from all existing files (and clear empty files)
  (i) Interactively select which configuration to keep
  
  How would you like to proceed in cleaning up the network configuration conflicts? 
  Please select 1 option: (m/c/d/i): i
  Conflicting netplan configurations found for interface 'eno1':
  1. eno1.yaml
  2. duplicate.yaml
  Which configuration do you want to keep for interface eno1? (Enter the number): 1
  Removed configuration for eno1 from /etc/netplan/duplicate.yaml
  
  Searching for configuration conflict(s) for interface eno2: 
      duplicate.yaml
      eno2.yaml
  
  Found conflicting configuration for interface eno2
  Would you like to view the contents of the files? (yes/NO): yes
  Viewing configuration files for eno2:
      1. /etc/netplan/duplicate.yaml
  Netplan Configuration: /etc/netplan/duplicate.yaml
  network:
    ethernets:
      eno2:
        addresses:
        - 192.168.254.254/30
        dhcp4: false
        dhcp6: false
    version: 2
      2. /etc/netplan/eno2.yaml
  Netplan Configuration: /etc/netplan/eno2.yaml
  network:
    version: 2
    ethernets:
      eno2:
        dhcp4: no
        dhcp6: no
        addresses: [192.168.254.254/30]
  (m) Manually address configuration file conflicts (exits)
  (c) Create new network interface configuration file
  (d) Delete network interface configuration from all existing files (and clear empty files)
  (i) Interactively select which configuration to keep
  
  How would you like to proceed in cleaning up the network configuration conflicts? 
  Please select 1 option: (m/c/d/i): i
  Conflicting netplan configurations found for interface 'eno2':
  1. duplicate.yaml
  2. eno2.yaml
  Which configuration do you want to keep for interface eno2? (Enter the number): 2
  Removed configuration for eno2 from /etc/netplan/duplicate.yaml
  Removed almost blank configuration file: duplicate.yaml
  ```
