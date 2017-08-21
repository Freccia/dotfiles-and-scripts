#!/usr/bin/env false


utmpdump < /var/log/wtmp > tmp.txt
utmpdump -r < tmp.txt | sudo tee /var/log/wtmp

# and

sudo cat /var/log/btmp | utmpdump > tmp.txt
utmpdump -r < tmp.txt | sudo tee /var/log/btmp
