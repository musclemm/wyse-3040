#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# 添加 PassWall 依赖与主程序源
#echo "src-git passwall_packages https://github.com" >> feeds.conf.default
#echo "src-git passwall https://github.com" >> feeds.conf.default

# 添加 OpenClash 源
echo "src-git openclash https://github.com" >> feeds.conf.default

# 添加 AdGuardHome 源
echo "src-git kenzo https://github.com" >> feeds.conf.default


