#!/bin/bash
# 脚本名称：python310_install.sh
# 功能：在Ubuntu系统中安装Python 3.10并配置默认python指向
# 使用方式：chmod +x python310_install.sh && sudo ./python310_install.sh

# 设置脚本执行模式：遇到错误立即退出，输出执行过程
set -e

# 检查是否以root权限运行
if [ "$(id -u)" -ne 0 ]; then
    echo "错误：该脚本需要root权限执行，请使用 sudo ./python310_install.sh" >&2
    exit 1
fi

# 打印提示信息
echo "========================================"
echo "开始安装Python 3.10（Ubuntu系统）"
echo "========================================"

# 1. 添加deadsnakes PPA源（提供新版Python）
echo "第一步：添加deadsnakes PPA源..."
# 先检查PPA是否已添加，避免重复添加
if ! grep -q "deadsnakes/ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    add-apt-repository ppa:deadsnakes/ppa -y
    echo "PPA源添加成功"
else
    echo "deadsnakes PPA源已存在，无需重复添加"
fi

# 2. 更新apt包索引
echo "第二步：更新apt包列表..."
apt update -y

# 3. 安装Python 3.10及相关依赖
echo "第三步：安装Python 3.10、pip和虚拟环境工具..."
apt install -y python3.10 python3-pip python3.10-venv

# 4. 配置默认python命令指向python3.10
echo "第四步：设置默认python指向Python 3.10..."
# 检查是否已配置过该替代项
if ! update-alternatives --list python | grep -q "/usr/bin/python3.10"; then
    update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1
    echo "默认python命令已指向python3.10（优先级1）"
else
    echo "python命令已配置为指向python3.10，无需重复设置"
fi

# 5. 验证安装结果
echo "第五步：验证Python安装结果..."
echo "python 命令指向版本：$(python --version)"
echo "python3.10 版本：$(python3.10 --version)"
echo "pip 版本：$(pip --version)"

# 安装完成提示
echo "========================================"
echo "Python 3.10安装并配置完成！"
echo "注意：可执行 python --version 确认默认版本"
echo "========================================"