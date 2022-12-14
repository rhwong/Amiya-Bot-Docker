#!/bin/bash

echo =================================================
echo	System Required: Docker Ubuntu
echo	Description: Amiya-Bot-Docker
echo	Version: 1.0.0
echo	Author: RHWong
echo =================================================

Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[信息]${Font_color_suffix}"
Error="${Red_font_prefix}[错误]${Font_color_suffix}"
Tip="${Green_font_prefix}[提示]${Font_color_suffix}"

# loading图标
function waiting()
{
i=0
while [ $i -le 100 ]
do
for j in '\\' '|' '/' '-'
do
printf "\t%c%c%c%c%c ${Info} 少女祈祷中... %c%c%c%c%c\r" \
"$j" "$j" "$j" "$j" "$j" "$j" "$j" "$j" "$j" "$j"
sleep 0.1
done
let i=i+4
done
}

# 通过http状态码判断网络连通性
function check_network()
{
    local ret_code=`curl -o /dev/null --connect-timeout 3 -s -w %{http_code} https://github.com`
    if [ "x$ret_code" = "x200" ]; then
        return 0
    else
        return 1
    fi
}


#判断Amiya-Bot目录是否存在  
install_Amiya()
{
if [ ! -d "Amiya-Bot" ]; then
    echo -e "${Info} Amiya-Bot目录已存在，无需安装！"
else
    echo -e "${Info} Amiya-Bot目录不存在，开始安装..."
    # 如果check_network函数返回0
    if [check_network -eq 0]; then
        echo -e "${Info} 网络连接正常，开始下载Amiya-Bot..."
        git clone https://github.com/AmiyaBot/Amiya-Bot.git
    else 
    # 如果check_network函数返回1，使用镜像下载  
        echo -e "${Info} 网络连接异常，开始使用镜像下载Amiya-Bot..."
        git clone https://ghproxy.com/https://github.com/AmiyaBot/Amiya-Bot.git
    fi
    echo -e "${Info} Amiya-Bot下载完成！"
fi
}

StartAmiya()
{
# 通过http状态码判断网络连通性
    if [ $(curl -o /dev/null --connect-timeout 3 -s -w %{http_code} https://github.com) -eq 200 ]; then
        echo -e "${Info} 网络连通性良好，使用Github下载"
        wget -N --no-check-certificate "https://raw.githubusercontent.com/AmiyaBot/Amiya-Bot/V6-master/requirements.txt"
        pip install --upgrade pip -r requirements.txt & waiting
    else
        echo -e "${Info} 网络连通性不佳，使用镜像下载"
        wget -N --no-check-certificate "https://ghproxy.com/https://raw.githubusercontent.com/AmiyaBot/Amiya-Bot/V6-master/requirements.txt"
        pip install --upgrade pip -r requirements.txt -i https://mirrors.cloud.tencent.com/pypi/simple & waiting
    fi
# 启动Amiya
echo -e "${Info} 依赖安装完成，开始启动Amiya" 
cd /workspace/Amiya-Bot && nohup python3 amiya.py >/dev/null 2>&1 &
# 检测是否启动成功
waiting
ps -ef | grep amiya.py | grep -v grep
if [ $? -eq 0 ]; then
    echo -e "${Info} Amiya-Bot 启动成功" 
else
    echo -e "${Error} Amiya-Bot 启动失败" && exit 1
fi
}
StartAmiya
