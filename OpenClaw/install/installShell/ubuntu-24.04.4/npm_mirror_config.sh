#!/bin/bash
# 脚本名称：npm_mirror_config.sh
# 功能：配置npm国内镜像源，并设置Puppeteer国内下载源（写入环境变量）
# 使用方式：chmod +x npm_mirror_config.sh && ./npm_mirror_config.sh

# 设置脚本执行模式：遇到错误立即退出，输出执行过程
set -e

# 打印提示信息
echo "========================================"
echo "开始配置npm国内镜像和Puppeteer下载源"
echo "========================================"

# 1. 配置npm默认镜像源为npmmirror
echo "第一步：配置npm国内镜像源..."
# 先检查当前npm镜像源，避免重复设置（可选，仅做提示）
current_registry=$(npm config get registry)
if [ "$current_registry" = "https://registry.npmmirror.com/" ]; then
    echo "npm镜像源已配置为npmmirror，无需重复设置"
else
    npm config set registry https://registry.npmmirror.com
    echo "npm镜像源已成功设置为：https://registry.npmmirror.com"
fi

# 2. 配置Puppeteer国内下载源（写入~/.bashrc）
echo "第二步：配置Puppeteer国内下载源..."
PUPPETEER_CONFIG='export PUPPETEER_DOWNLOAD_BASE_URL=https://cdn.npmmirror.com/binaries/chromium-browser-snapshots'
# 检查环境变量是否已存在，避免重复写入
if ! grep -q "PUPPETEER_DOWNLOAD_BASE_URL=https://cdn.npmmirror.com/binaries/chromium-browser-snapshots" ~/.bashrc; then
    echo "$PUPPETEER_CONFIG" >> ~/.bashrc
    echo "Puppeteer下载源已写入~/.bashrc"
else
    echo "Puppeteer下载源已存在，无需重复写入"
fi

# 3. 立即生效环境变量（当前会话）
echo "第三步：生效当前会话的环境变量..."
source ~/.bashrc

# 4. 验证配置结果
echo "第四步：验证配置结果..."
echo "当前npm镜像源：$(npm config get registry)"
echo "当前Puppeteer下载源：$PUPPETEER_DOWNLOAD_BASE_URL"

# 配置完成提示
echo "========================================"
echo "npm镜像和Puppeteer下载源配置完成！"
echo "注意：新的ssh会话需要重新登录，Puppeteer环境变量才会永久生效"
echo "========================================"