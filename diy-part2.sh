#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# 1. 修改默认后台管理 IP（按需取消注释）
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# 2. 将 Argon 设为默认主题（兼容新旧 OpenWrt 分支）
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
[ -f feeds/luci/collections/luci-light/Makefile ] && sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-light/Makefile

# 3. 预置 OpenClash Meta (Mihomo) x86_64 v1 内核（兼容 Atom x5-Z8350）
mkdir -p files/etc/openclash/core
CLASH_META_URL=$(curl -sL https://api.github.com/repos/MetaCubeX/mihomo/releases/latest | grep -oE "https://[^\"]*mihomo-linux-amd64-v1-v[0-9.]+\.gz" | head -n 1)
if [ -n "$CLASH_META_URL" ]; then
    echo "Downloading Clash Meta core from: $CLASH_META_URL"
    curl -fsSL "$CLASH_META_URL" -o /tmp/clash_meta.gz && \
    gzip -df /tmp/clash_meta.gz && \
    mv /tmp/clash_meta files/etc/openclash/core/clash_meta && \
    chmod +x files/etc/openclash/core/clash_meta
else
    echo "Warning: Failed to fetch Mihomo download URL!"
fi

# 4. 预置 AdGuardHome x86_64 核心二进制文件（直接放到 /usr/bin/AdGuardHome）
mkdir -p files/usr/bin
AGH_URL=$(curl -sL https://api.github.com/repos/AdguardTeam/AdGuardHome/releases/latest | grep -oE "https://[^\"]*AdGuardHome_linux_amd64\.tar\.gz" | head -n 1)
if [ -n "$AGH_URL" ]; then
    echo "Downloading AdGuardHome core from: $AGH_URL"
    curl -fsSL "$AGH_URL" -o /tmp/AdGuardHome.tar.gz && \
    tar -zxf /tmp/AdGuardHome.tar.gz -C /tmp/ && \
    mv /tmp/AdGuardHome/AdGuardHome files/usr/bin/AdGuardHome && \
    chmod +x files/usr/bin/AdGuardHome && \
    rm -rf /tmp/AdGuardHome /tmp/AdGuardHome.tar.gz
else
    echo "Warning: Failed to fetch AdGuardHome download URL!"
fi
chmod +x files/usr/bin/AdGuardHome/AdGuardHome
rm -rf /tmp/AdGuardHome /tmp/AdGuardHome.tar.gz
