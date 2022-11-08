#!/bin/sh
if [ ! -f /etc/mosdns/config.yaml ]; then
mkdir -p /etc/mosdns/
cp -u /config.yaml /etc/mosdns/config.yaml
fi
cp -u /geosite.dat /etc/mosdns/geosite.dat
cp -u /geoip.dat /etc/mosdns/geoip.dat
/usr/bin/mosdns start --dir /etc/mosdns
