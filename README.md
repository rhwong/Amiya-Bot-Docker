<div align="center">

# Amiya-Bot-Docker

用于快速部署基于 [AmiyaBot](https://github.com/AmiyaBot/Amiya-Bot) 框架的 QQ 聊天机器人的Docker<br>

注意：本项目仅用于快速部署AmiyaBot本体，后续对接何种前端(如[Go-cqhtp](https://github.com/Mrs4s/go-cqhttp/))取决您自己的选择，这些部分并不包含在Docker镜像内，请参考官方教程。

</div>
<!-- projectInfo end -->

## 快速启动

```shell
cd ~
mkdir -p Amiya-Bot/log
mkdir -p Amiya-Bot/database
```
拉取镜像

```shell
docker pull rhwong/amiya-bot
```
### 容器创建
```shell
docker run -it --name="amiya" -m 1024M \
-p 0.0.0.0:18080:8080 \
-v "$(pwd)"/Amiya-Bot/log:/workspace/Amiya-Bot/log \
-v "$(pwd)"/Amiya-Bot/database:/workspace/Amiya-Bot/database  \
--restart=always rhwong/amiya-bot
```


