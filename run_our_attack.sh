#!/bin/bash
set -e

echo "🛠️ 更新系统和安装必要工具..."
sudo apt update
sudo apt install -y software-properties-common curl wget build-essential
sudo apt install -y python3-pip
pip3 install virtualenv  --break-system-packages

alias pydoc 2>/dev/null >/dev/null && unalias pydoc || true
alias python=python3
alias pip="python3 -m pip"

echo "✅ 安装 G6K 构建依赖（gmp、mpfr、qd等）..."
sudo apt-get install -y autoconf automake pkg-config
sudo apt-get install -y libtool-bin libgmp-dev
sudo apt-get install -y libmpfr-dev
sudo apt-get install -y libqd-dev

echo "📂 克隆并安装 G6K..."
rm -rf g6k
git clone https://github.com/fplll/g6k.git
cd g6k
pip install -r requirements.txt --break-system-packages
PYTHON=python3 ./bootstrap.sh -j 8


echo "📂 克隆并安装 Our method..."
rm -rf Artifacts
git clone https://github.com/Halowooder/Artifacts.git
cp -r g6k Artifacts

echo "🎉 所有步骤完成！你现在可以使用 G6K 了。"