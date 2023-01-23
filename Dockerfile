# mosdns v5
FROM --platform=${TARGETPLATFORM} golang:alpine as builder
ARG CGO_ENABLED=0
ARG TAG
ARG REPOSITORY

WORKDIR /root
RUN apk add --update git \
	&& git clone https://github.com/${REPOSITORY} mosdns \
	&& cd ./mosdns \
	&& git fetch --all --tags \
	&& git checkout tags/${TAG} \
	&& go build -ldflags "-s -w -X main.version=${TAG}" -trimpath -o mosdns

FROM --platform=${TARGETPLATFORM} alpine:latest
LABEL maintainer="Sgit <github.com/Sagit-chu>"

COPY --from=builder /root/mosdns/mosdns /usr/bin/

RUN apk add --no-cache ca-certificates \
	&& mkdir /etc/mosdns
ADD entrypoint.sh /entrypoint.sh
ADD config.yaml /config.yaml
ADD hosts /hosts
# ADD https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geoip.dat /geoip.dat
# ADD https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geosite.dat /geosite.dat
ADD https://raw.githubusercontent.com/IceCodeNew/4Share/master/geoip_china/china_ip_list.txt /geoip_cn.txt
ADD https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/reject-list.txt /geosite_category-ads-all.txt
ADD https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/proxy-list.txt /geosite_geolocation-!cn.txt
ADD https://raw.githubusercontent.com/Loyalsoldier/v2ray-rules-dat/release/direct-list.txt /geosite_cn.txt

VOLUME /etc/mosdns
EXPOSE 53/udp 53/tcp
RUN chmod +x /entrypoint.sh
CMD ["sh", "/entrypoint.sh"]
