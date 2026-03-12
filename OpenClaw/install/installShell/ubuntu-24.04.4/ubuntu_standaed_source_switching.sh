#!/bin/bash

# 定义软件源列表文件路径
SOURCES_LIST="/etc/apt/sources.list"
SOURCES_LIST_D="/etc/apt/sources.list.d/"

# 备份原始软件源列表
cp $SOURCES_LIST $SOURCES_LIST.bak
echo "Backup of the original sources.list has been created."

# 定义新的镜像源地址
MIRROR="http://mirrors.aliyun.com/ubuntu"

# 获取Ubuntu的版本代号
UBUNTU_CODENAME=$(lsb_release -c | cut -f2)

# 创建新的sources.list文件
echo "Creating a new sources.list file..."
cat > $SOURCES_LIST << EOF
# Default settings for Ubuntu
# See http://help.ubuntu.com/community/UpgradeNotes for how to upgrade to
# newer versions of the distribution.

deb $MIRROR $UBUNTU_CODENAME main restricted
deb-src $MIRROR $UBUNTU_CODENAME main restricted

## Major bug fix updates produced after the final release of the
## distribution.
deb $MIRROR $UBUNTU_CODENAME-updates main restricted
deb-src $MIRROR $UBUNTU_CODENAME-updates main restricted

## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
## team, and may not be under a free licence. Please satisfy yourself as to
## your rights to use the software. Also, please note that software in
## universe WILL NOT receive any review or updates from the Ubuntu security
## team.
deb $MIRROR $UBUNTU_CODENAME universe
deb-src $MIRROR $UBUNTU_CODENAME universe
deb $MIRROR $UBUNTU_CODENAME-updates universe
deb-src $MIRROR $UBUNTU_CODENAME-updates universe

## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
## team, and may not be under a free licence. Please satisfy yourself as to
## your rights to use the software. Also, please note that software in
## multiverse WILL NOT receive any review or updates from the Ubuntu
## security team.
deb $MIRROR $UBUNTU_CODENAME multiverse
deb-src $MIRROR $UBUNTU_CODENAME multiverse
deb $MIRROR $UBUNTU_CODENAME-updates multiverse
deb-src $MIRROR $UBUNTU_CODENAME-updates multiverse

## N.B. software from this repository may not have been tested as
## extensively as that contained in the main release, although it includes
## newer versions of some applications which may provide useful features.
## Also, please note that software in backports WILL NOT receive any review
## or updates from the Ubuntu security team.
deb $MIRROR $UBUNTU_CODENAME-backports main restricted universe multiverse
deb-src $MIRROR $UBUNTU_CODENAME-backports main restricted universe multiverse

## Uncomment the following two lines to add software from Canonical's
## 'partner' repository.
## This software is not part of Ubuntu, but is offered by Canonical and the
## respective vendors as a service to Ubuntu users.
# deb http://archive.canonical.com/ubuntu $UBUNTU_CODENAME partner
# deb-src http://archive.canonical.com/ubuntu $UBUNTU_CODENAME partner

deb $MIRROR $UBUNTU_CODENAME-security main restricted
deb-src $MIRROR $UBUNTU_CODENAME-security main restricted
deb $MIRROR $UBUNTU_CODENAME-security universe
deb-src $MIRROR $UBUNTU_CODENAME-security universe
deb $MIRROR $UBUNTU_CODENAME-security multiverse
deb-src $MIRROR $UBUNTU_CODENAME-security multiverse
EOF

# 更新软件包列表
echo "Updating package lists..."
apt-get update

echo "The sources.list has been updated to use the Aliyun mirrors."
