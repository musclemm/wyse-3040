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

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

# ==========================================================
# 预置 OpenClash Meta (Mihomo) x86_64 内核
# ==========================================================
mkdir -p files/etc/openclash/core

CLASH_META_URL=$(curl -sL https://github.com | grep -oE "https://.*mihomo-linux-amd64-v1-v[0-9.]+\.gz" | head -n 1)
if [ -z "$CLASH_META_URL" ]; then
    CLASH_META_URL=$(curl -sL https://github.com | grep -oE "https://.*mihomo-linux-amd64-v[0-9.]+\.gz" | head -n 1)
fi

echo "Downloading Clash Meta core from: $CLASH_META_URL"
curl -sL "$CLASH_META_URL" -o /tmp/clash_meta.gz
gzip -d /tmp/clash_meta.gz
mv /tmp/clash_meta files/etc/openclash/core/clash_meta
chmod +x files/etc/openclash/core/clash_meta

# ==========================================================
# 预置 AdGuardHome x86_64 核心二进制文件
# ==========================================================
mkdir -p files/usr/bin/AdGuardHome

AGH_URL=$(curl -sL https://github.com | grep -oE "https://.*AdGuardHome_linux_amd64\.tar\.gz" | head -n 1)

echo "Downloading AdGuardHome core from: $AGH_URL"
curl -sL "$AGH_URL" -o /tmp/AdGuardHome.tar.gz
tar -zxf /tmp/AdGuardHome.tar.gz -C /tmp/
mv /tmp/AdGuardHome/AdGuardHome files/usr/bin/AdGuardHome/AdGuardHome
chmod +x files/usr/bin/AdGuardHome/AdGuardHome
rm -rf /tmp/AdGuardHome /tmp/AdGuardHome.tar.gz

