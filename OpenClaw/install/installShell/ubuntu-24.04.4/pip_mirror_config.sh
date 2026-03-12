#!/bin/bash
# 脚本名称：pip_mirror_config.sh
# 功能：配置pip国内镜像（阿里云源），自动创建配置文件并验证
# 使用方式：chmod +x pip_mirror_config.sh && ./pip_mirror_config.sh

# 设置脚本执行模式：遇到错误立即退出，输出执行过程
set -e

# 打印提示信息
echo "========================================"
echo "开始配置pip国内镜像（阿里云源）"
echo "========================================"

# 1. 创建pip配置目录（-p确保目录不存在时创建，存在时不报错）
echo "第一步：创建pip配置目录..."
mkdir -p ~/.config/pip

# 2. 写入pip配置文件（覆盖原有配置，避免手动vi编辑）
echo "第二步：写入pip镜像配置..."
PIP_CONFIG_FILE=~/.config/pip/pip.conf

# 定义要写入的配置内容
PIP_CONFIG_CONTENT="[global]
index-url = https://mirrors.aliyun.com/pypi/simple/
[install]
trusted-host = mirrors.aliyun.com"

# 先检查配置文件是否已存在且内容一致，避免重复写入
if [ -f "$PIP_CONFIG_FILE" ]; then
    if diff <(echo "$PIP_CONFIG_CONTENT") "$PIP_CONFIG_FILE" >/dev/null; then
        echo "pip镜像配置已存在且内容一致，无需修改"
    else
        # 备份原有配置，再写入新配置
        mv "$PIP_CONFIG_FILE" "$PIP_CONFIG_FILE.bak"
        echo "$PIP_CONFIG_CONTENT" > "$PIP_CONFIG_FILE"
        echo "pip配置文件已更新（原有文件备份为：$PIP_CONFIG_FILE.bak）"
    fi
else
    # 配置文件不存在，直接写入
    echo "$PIP_CONFIG_CONTENT" > "$PIP_CONFIG_FILE"
    echo "pip配置文件已创建并写入阿里云镜像配置"
fi

# 3. 验证配置结果
echo "第三步：验证pip配置..."
echo "当前pip配置列表："
pip config list

# 额外验证：打印配置文件内容，确认写入正确
echo -e "\n当前pip.conf配置文件内容："
cat "$PIP_CONFIG_FILE"

# 配置完成提示
echo "========================================"
echo "pip国内镜像配置完成！"
echo "后续使用pip install会自动使用阿里云源，下载速度更快"
echo "========================================"