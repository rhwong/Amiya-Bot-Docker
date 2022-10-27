#!/bin/bash

#=================================================
#	System Required: Docker Ubuntu
#	Description: Amiya-Bot-Docker
#	Version: 1.0.0
#	Author: RHWong
#=================================================

Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[信息]${Font_color_suffix}"
Error="${Red_font_prefix}[错误]${Font_color_suffix}"
Tip="${Green_font_prefix}[注意]${Font_color_suffix}"


# 检查网络连通性
    ping -c 1 -W ${Timeout} github.com > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        # 无法连接Github，使用镜像下载
        echo -e "${Info} 无法连接Github，使用镜像下载" 
        wget -N --no-check-certificate "https://ghproxy.com/https://raw.githubusercontent.com/AmiyaBot/Amiya-Bot/V6-master/requirements.txt"
    else
        # 连接Github，使用Github下载
        echo -e "${Info} 连接Github，使用Github下载" 
        wget -N --no-check-certificate "https://raw.githubusercontent.com/AmiyaBot/Amiya-Bot/V6-master/requirements.txt"
    fi
# 升级依赖
pip install --upgrade pip -r requirements.txt

# 启动Amiya
cd /workspace/AmiyaBot && nohup python3 amiya.py >/dev/null 2>&1 &
# 检测是否启动成功
sleep 30
ps -ef | grep amiya.py | grep -v grep
if [ $? -eq 0 ]; then
    echo -e "${Info} Amiya-Bot 启动成功" 
else
    echo -e "${Error} Amiya-Bot 启动失败" && exit 1
fi
