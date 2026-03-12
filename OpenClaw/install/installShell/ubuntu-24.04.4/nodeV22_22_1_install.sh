#!/bin/bash
# 脚本名称：node_install.sh
# 功能：安装Node.js v22.22.1（国内镜像）并配置环境变量
# 使用方式：chmod +x node_install.sh && ./node_install.sh

# 设置脚本执行模式：遇到错误立即退出，输出执行过程
set -e

# 打印提示信息
echo "========================================"
echo "开始安装Node.js v22.22.1（国内镜像源）"
echo "========================================"

# 1. 下载并解压Node.js安装包（国内npmmirror镜像）
echo "第一步：下载Node.js v22.22.1安装包..."
curl -fsSL https://registry.npmmirror.com/-/binary/node/v22.22.1/node-v22.22.1-linux-x64.tar.xz | sudo tar -xJ -C /usr/local/

# 2. 配置环境变量到~/.bashrc
echo "第二步：配置Node.js环境变量..."
# 先检查环境变量是否已存在，避免重复写入
if ! grep -q "/usr/local/node-v22.22.1-linux-x64/bin" ~/.bashrc; then
    echo "export PATH=/usr/local/node-v22.22.1-linux-x64/bin:\$PATH" >> ~/.bashrc
    echo "环境变量已写入~/.bashrc"
else
    echo "环境变量已存在，无需重复写入"
fi

# 3. 立即生效环境变量（当前会话）
echo "第三步：生效环境变量..."
source ~/.bashrc

# 4. 验证安装是否成功
echo "第四步：验证Node.js安装结果..."
node -v  # 预期输出：v22.22.1
npm -v

# 安装完成提示
echo "========================================"
echo "Node.js v22.22.1安装并配置完成！"
echo "注意：如果是ssh远程连接，重新登录后环境变量会永久生效"
echo "========================================"