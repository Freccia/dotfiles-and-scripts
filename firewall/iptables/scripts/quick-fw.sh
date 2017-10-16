#!/usr/bin/env bash

# NOT ALREADY CHECKED
echo "NOT ALREADY CHECKED"
exit 1

#### USAGE	####
cat > /etc/firewall.d/1_nginx.conf <<EOF 
		/sbin/iptables -A  INPUT -p tcp --dport 80 - j ACCEPT 
EOF

echo "See Usage."
exit 1

set -x
IPT=iptables
IPT6=ip6tables

# Base config
# ip forward ?
echo 1 > /proc/sys/net/ipv4/ip_forward
# reset
$IPT -F
$IPT -X
$IPT -t nat -F
$IPT -t nat -X
$IPT -t mangle -F
$IPT -t mangle -X
$IPT -P INPUT DROP
$IPT -P FORWARD DROP
$IPT -P OUTPUT DROP
#$IPT -F
$IPT6 -X
$IPT6 -F
$IPT6 -t nat -F
$IPT6 -t nat -X
$IPT6 -t mangle -F
$IPT6 -t mangle -X
$IPT6 -P INPUT DROP
$IPT6 -P FORWARD DROP
$IPT6 -P OUTPUT DROP
$IPT6 -P INPUT DROP
$IPT6 -P FORWARD DROP
$IPT6 -P OUTPUT ACCEPT

# INPUT BASE
$IPT -A INPUT -s 127.0.0.1 -i lo -j ACCEPT
$IPT6 -A INPUT -i lo -j ACCEPT
$IPT -A INPUT -p tcp ! --syn -m state --state NEW,INVALID -j REJECT
$IPT -A INPUT -p icmp --icmp-type 8 -j ACCEPT
#$IPT -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --name BLACKLIST --set
#$IPT -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --name BLACKLIST --update --seconds 60 --hitcount 30 --rttl -j DROP
$IPT -A INPUT -p tcp --dport 22 -j ACCEPT
# FORWARD BASE

# OUTPUT BASE
$IPT -A OUTPUT -p icmp -j ACCEPT
$IPT -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# NAT BASE

# dyn config
if [ -d /etc/firewall.d ];then
    cd /etc/firewall.d
    for f in $(find . -type f -iname '*.conf'|sort -n);do
        bash -x ${f}
    done
else
    mkdir -p /etc/firewall.d
fi

# END CONFIG
# INPUT END
$IPT -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPT6 -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
#$IPT -A INPUT -m limit --limit 5/m --limit-burst 15 -j LOG --log-prefix "DROP IPTABLES: INPUT: " --log-level 4
$IPT -A INPUT -j DROP
# FORWARD END
$IPT -A FORWARD -m limit --limit 5/m --limit-burst 15 -j LOG --log-prefix "DROP IPTABLES: FORWARD: " --log-level 4
$IPT -A FORWARD -j DROP
# OUTPUT END
$IPT -A OUTPUT -j ACCEPT

# save iptables rules
if [ -d /etc/iptables ];then
	/sbin/ip6tables-save > /etc/iptables/rules.v6
	/sbin/iptables-save > /etc/iptables/rules.v4
fi
# reload services
if [ -e /etc/init.d/fail2ban ]; then
  /etc/init.d/fail2ban restart
fi

