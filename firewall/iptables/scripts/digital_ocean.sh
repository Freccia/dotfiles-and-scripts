#!/usr/bin/env bash
echo "Be careful. Add an argument tu run" 
test $1 || exit 1

sudo iptables -P INPUT DROP
sudo iptables -p FORWARD DROP
sudo iptables -P OUTPUT ACCEPT

sudo iptables -A INPUT -i lo -j DROP
sudo iptables -A OUTPUT -o lo -j ACCEPT

# module conntrack
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED -j ACCEPT

# drop invalid
sudo iptables -A INPUT -m conntrack --ctstate INVALID -j DROP

# tcp
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# loopback
sudo iptables -I INPUT 1 -i lo -j ACCEPT

