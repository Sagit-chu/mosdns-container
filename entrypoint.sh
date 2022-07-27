#!/bin/sh
if [ ! -f /etc/mosdns/config.yaml ]; then
	mkdir -p /etc/mosdns/
	mv /config.yaml /etc/mosdns/config.yaml
    	mv /geosite.dat /etc/mosdns/geosite.dat
    	mv /geoip.dat /etc/mosdns/geoip.dat
fi
/usr/bin/mosdns start --dir /etc/mosdns
