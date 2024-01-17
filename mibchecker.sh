#!/usr/bin/bash
OUTLOG="snmpwalk-output.log"
ip=$1
if [ $# -eq 0 ]; then
    >&2 echo "No SNMP host IP address provided"
    echo "Usage: "
    echo "    $0 <ip.add.es.s>"
    exit 1
fi


isValidIP() {
    local ip=$1
    local stat=1

    if [[ $ip =~ ^[0-9]{1,3}(\.[0-9]{1,3}){3}$ ]]; then
        IFS='.' read -ra addr <<< "$ip"
        [[ ${addr[0]} -le 255 && ${addr[1]} -le 255 && ${addr[2]} -le 255 && ${addr[3]} -le 255 ]]
        stat=$?
    fi

    return $stat
}

if isValidIP "$ip"; then
    echo "Valid IP"
else
    echo "Invalid IP"
	exit 1
fi

COMMAND="snmpwalk -v3 -l authPriv -u superUser -A sha512passphrase -x AES -a SHA-512 -X aespassphrase $ip"


echo "CPU Thread/Core Count:" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.25.3.3.1.2 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Per-CPU Load:" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.25.3.3.1.2 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Load Average 1 minute:" >> "$OUTLOG"
$COMMAND 1.3.6.1.4.1.2021.10.1.3.1 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Load Average 5 minutes:" >> "$OUTLOG"
$COMMAND 1.3.6.1.4.1.2021.10.1.3.2 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Load Average 15 minutes:" >> "$OUTLOG"
$COMMAND 1.3.6.1.4.1.2021.10.1.3.3 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "CPU Utilization:" >> "$OUTLOG"
$COMMAND 1.3.6.1.4.1.2021.11 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Memory Installed:" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.25.2.2.0 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Memory In Use:" >> "$OUTLOG"
$COMMAND 1.3.6.1.4.1.2021.4.6.0 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Memory Free:" >> "$OUTLOG"
$COMMAND 1.3.6.1.4.1.2021.4.11.0 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Swap Partition Size:" >> "$OUTLOG"
$COMMAND 1.3.6.1.4.1.2021.4.3.0 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Swap In Use:" >> "$OUTLOG"
$COMMAND 1.3.6.1.4.1.2021.4.4.0 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Swap Free:" >> "$OUTLOG"
$COMMAND 1.3.6.1.4.1.2021.4.5.0 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Disks Installed:" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.25.3.8 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Partition Size for All Mounted Partitions:" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.25.2.3.1.5 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Partition Mount Point:" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.25.2.3.1.3 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Partition Utilization:" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.25.2.3.1.6 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Total Size of a Storage Area:" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.25.2.3.1.5 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Used Space of a Storage Area:" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.25.2.3.1.6 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Running Processes:" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.25.1.6.0 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Network Interface Name:" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.2.2.1.2 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Network Interface IP Address:" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.4.20.1.2 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Network Interface MAC Address:" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.2.2.1.6 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Network interface index number (ifIndex):" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.2.2.1.1 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Network interface Description (ifDescr):" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.2.2.1.2 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Network interface bytes inbound (ifInOctets):" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.2.2.1.10 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Network interface bytes outbound (ifOutOctets):" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.2.2.1.16 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Network interface inbound errors (ifInErrors):" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.2.2.1.14 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Network interface outbound errors (ifOutErrors):" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.2.2.1.20 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Network interface operational status (ifOperStatus) (up/down):" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.2.2.1.8 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Packets Received:" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.2.2.1.11 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Packets Sent:" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.2.2.1.17 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "SNMP Messages Received:" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.11.1 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "SNMP Messages Sent:" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.11.2 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Logged in Users:" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.25.1.5 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Running Processes:" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.25.4.2.1.2 >> "$OUTLOG"
echo "" >> "$OUTLOG"

echo "Running Process Arguments:" >> "$OUTLOG"
$COMMAND 1.3.6.1.2.1.25.4.2.1.5 >> "$OUTLOG"
echo "" >> "$OUTLOG"


echo "Please see $OUTLOG for status information"
