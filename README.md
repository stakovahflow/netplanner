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


Examples:

Configuration Backup:
  superuser@system:~$ sudo ./netplanner --backup
  Backing up netplan configuration files
  Backing up /etc/netplan to /var/log/netplan-backup-2024-03-12_22-13-16.tgz
  Backup created: /var/log/netplan-backup-2024-03-12_22-13-16.tgz
  To restore this configuration, run: sudo ./netplanner --restore /var/log/netplan-backup-2024-03-12_22-13-16.tgz

