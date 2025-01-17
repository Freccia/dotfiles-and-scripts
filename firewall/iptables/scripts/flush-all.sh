#!/bin/sh

# This script flushes all iptables rules
# you'll end up with no firewall

echo "Stopping firewall and allowing everyone..."
ipt="/sbin/iptables"
## Failsafe - die if /sbin/iptables not found
[ ! -x "$ipt" ] && { echo "$0: \"${ipt}\" command not found."; exit 1; }
$ipt -P INPUT ACCEPT
$ipt -P FORWARD ACCEPT
$ipt -P OUTPUT ACCEPT
$ipt -F
$ipt -X
$ipt -t nat -F
$ipt -t nat -X
$ipt -t mangle -F
$ipt -t mangle -X
$ipt iptables -t raw -F
$ipt -t raw -X
