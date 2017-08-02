#!/usr/bin/env bash


wget http://ipecho.net/plain -O - -q ; echo

if [ $# -gt 1 ];then
		if [ $1 == "-full" ];then
				curl http://ipleak.com/full-report > ipleak.html
		else
				echo "Usage: ./pubip.sh [-full]"
		fi
fi
