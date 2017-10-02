#!/bin/bash

#Get ip info

if [ $# -ge 1 ];then
	curl http://torstatus.blutmagie.de/cgi-bin/whois.pl?ip=$1
else
	curl http://torstatus.blutmagie.de/cgi-bin/whois.pl
fi
