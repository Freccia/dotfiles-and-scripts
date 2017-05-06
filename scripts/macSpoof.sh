#!/bin/bash

# Make sure you are root
#if [[ $EUID -ne 0 ]]; then
#   echo "This script must be run as root." 1>&2
#   exit 1
#fi

# Test if you inputted the device name
if [[ $# < 1 ]]; then
	printf "Wrong number of arguments.\n"
	printf "Usage: ./macSpoof.sh [device-name]\n"
	exit 1
fi

CUR_MAC=`ifconfig | grep -C 3 $1 | grep ether |
		sed "s/^.* \(\([0-9a-z]\{2\}:\)\{5\}[0-9a-z]\{2\}\).*$/\1/"`
# Or maybe this is better...
# CUR_MAC=`cat /sys/class/net/$1/address`

if [[ -z $CUR_MAC ]];then
	printf "Could not find this device.\n"
	exit 1
fi

printf "Current MAC found: $CUR_MAC\n"

NEW_MAC=`openssl rand -hex 6 | sed 's/\(..\)/\1:/g;s/.$//'`
TEST=`echo $NEW_MAC | sed 's/\(..\).*$/\1/g'`
echo $TEST

#sudo ifconfig $1 down

if [[ $? != 0 ]];then
	printf "An error occurred. Abort.\n"
	exit 1
fi


