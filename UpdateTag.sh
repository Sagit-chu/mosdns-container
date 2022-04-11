#!/bin/bash
wget -qO- -t1 -T2 "https://api.github.com/repos/IrineSistiana/mosdns/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g' > tag