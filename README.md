![mosdns](https://truecharts.org/_static/img/appicons/mosdns.png)


# mosdns
一个插件化的 DNS 转发/分流器。

项目地址: [github.com/IrineSistiana/mosdns](https://github.com/IrineSistiana/mosdns)

Dockerfile: [github.com/Sagit-chu/mosdns-container](https://github.com/Sagit-chu/mosdns-container)
# 支持的平台
* `linux/amd64`
* `linux/arm/v7`
* `linux/arm64`

# 关于镜像
镜像基于 `alpine:latest`。包含 mosdns 和，TLS 需要的 ca 根证书包，配置文件，geoip.dat，geosite.dat。


配置文件在[github.com/Sagit-chu/mosdns-container](https://github.com/Sagit-chu/mosdns-container)


geoip.dat，geosite.dat会随着镜像更新
# 启动容器
```
docker run -d --name mosdns -p 5454:53/udp -p 5454:53/tcp  sagit.io/601096721/mosdns:latest
```

因为容器已经包含了配置文件，所以可以不映射`/etc/mosdns`，如果需要修改配置文件可以映射你的设置文件。
