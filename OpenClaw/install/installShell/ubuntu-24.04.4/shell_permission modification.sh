#!/bin/bash
# 精确给指定 .sh 文件设置 740 权限

files=(
  "nodeV22_22_1_install.sh"
  "npm_mirror_config.sh"
  "pip_mirror_config.sh"
  "python_3.10_install.sh"
  "ubuntu_standaed_source_switching.sh"
)

for file in "${files[@]}"
do
    if [ -f "$file" ]; then
        chmod 740 "$file"
        echo "已设置: $file"
    else
        echo "警告: 文件 $file 不存在，跳过"
    fi
done

echo "权限修改完成！"
