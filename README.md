![mosdns](https://truecharts.org/img/hotlink-ok/chart-icons/mosdns.png)


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

**流程：**

   - cn 域名 -> 国内上游dot doh
        返回是国内 ip -> 返回结果,结束.
        不是国内 ip 继续下一步.
   - 非 cn 域名 -> 无污染dot doh上游
        返回非国内 ip ? -> 返回结果,结束.
        返回国内 ip 继续下一步.
   - 其他所有情况,优先无污染上游结果,否则国内上游结果.



geoip.dat，geosite.dat会随着镜像更新（不要挂载配置文件，或者挂载为emptyDir才会随镜像更新）
# 启动容器
```
docker run -d --name mosdns -p 5454:53/udp -p 5454:53/tcp  sagit.io/601096721/mosdns:latest
```

因为容器已经包含了配置文件，所以可以不映射`/etc/mosdns`，如果需要修改配置文件可以映射配置目录。
