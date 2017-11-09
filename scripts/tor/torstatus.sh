#!/bin/bash

#Get ip info

curl https://check.torproject.org | \
    grep -ie "Congratulations" -e "Your IP" | sed 's/<[^>]*>//g' | sed 's/^ *//' | uniq

exit 0

if [ $# -ge 1 ];then
	curl http://torstatus.blutmagie.de/cgi-bin/whois.pl?ip=$1
else
	curl http://torstatus.blutmagie.de/cgi-bin/whois.pl
fi
