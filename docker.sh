#!/usr/bin/env bash

如果 [[ $EUID -ne 0 ]]
然后
    清除
    echo "错误：本脚本需要root权限执行。" 1>&2
    1号出口
菲

a=$(curl --noproxy '*' -sSL https://api.myip.com/)
b="中国"
如果 [[ $a == *$b* ]]
然后
  echo "错误：本脚本不支持境内服务器使用。" 1>&2
  1号出口
菲

欢迎 （） {
    回声
    echo "即将开始"
    echo "如果您想取消安装，"
    echo "请在 5 秒内按 Ctrl+C 终止此脚本。"
    回声
    睡觉 5
}

码头工人检查（）{
    echo "正在检查 Docker 安装情况 ..."
    如果命令 -v docker >> /dev/null 2>&1;
    然后
        echo "Docker 似乎存在，安装过程继续......"
    别的
        echo "Docker 未安装在此系统上"
        echo "请安装 Docker 并将自己添加到 Docker"
        echo "分组并重新运行这个脚本。"
        1号出口
    菲
}

访问检查（）{
    echo "测试 Docker 环境..."
    如果 [ -w /var/run/docker.sock ]
    然后
        echo "该用户可以使用 Docker，安装过程继续......"
    别的
        echo "该用户无访问权 Docker，或者 Docker 没有运行。请添加自己到 Docker 分组并重新运行此脚本。"
        1号出口
    菲
}

build_docker () {
    printf "请输入 PagerMaid 容器的名称："
    读取 -r 容器名称 <&1
    echo "正在拉取 Docker 镜像..."
    docker rm -f "$container_name" > /dev/null 2>&1
    docker pull mrwangzhe/pagermaid_modify
}

start_docker () {
    echo "正在启动 Docker 容器..."
    docker run -dit --network host --restart=always --name="$container_name" --hostname="$container_name" mrwangzhe/pagermaid_modify <&1
    回声
    echo "开始配置参数..."
    echo "在登录后，请按 Ctrl + C 使容器在后台模式下重新启动。"
    睡觉 3
    docker exec -it $container_name bash utils/docker-config.sh
    回声
    echo "Docker 创建完毕。"
    回声
}

数据持久性（）{
    echo "数据插件化容器可以在升级或重新部署时保留配置文件和。"
    printf "请确认是否进行数据化操作[Y/n]："
    读取 -r 持久性 <&1
    案例$persistence in
        [yY][eE][sS] | [年年])
            printf "请将数据输出在机器的哪个路径（绝对路径），同时请确保该路径下没有名为 workdir 的文件夹的输入：
            读取 -r 数据路径 <&1
            如果 [ -d $data_path ]; 然后
                如果 [[ -z $container_name ]]; 然后
                    printf "请输入 PagerMaid 容器的名称："
                    读取 -r 容器名称 <&1
                菲
                如果 docker 检查 $container_name &>/dev/null; 然后
                    docker cp $container_name:/pagermaid/workdir $data_path
                    docker stop $container_name &>/dev/null
                    docker rm $container_name &>/dev/null
                    docker run -dit -e PUID=$PUID -e PGID=$PGID -v $data_path/workdir:/pagermaid/workdir --network host --restart=always --name="$container_name" --hostname="$container_name" mrwangzhe/ pagermaid_modify <&1
                    回声
                    echo "数据化操作完成。"
                    回声
                    shon_online
                别的
                    echo "不存在名为$container_name的容器，退出。"
                    1号出口
                菲
            别的
                echo "路径$data_path不存在，退出。"
                1号出口
            菲
            ;;
        [nN][oO] | [nN])
            echo "结束。"
            ;;
        *)
            echo "输入错误..."
            1号出口
            ;;
    经社理事会
}

开始安装（）{
    欢迎
    docker_check
    access_check
    build_docker
    start_docker
    数据持久性
}

清理 （） {
    printf "请输入 PagerMaid 容器的名称："
    读取 -r 容器名称 <&1
    echo "删除开始Docker镜像..."
    如果 docker 检查 $container_name &>/dev/null; 然后
        docker rm -f "$container_name" &>/dev/null
        回声
        shon_online
    别的
        echo "不存在名为$container_name的容器，退出。"
        1号出口
    菲
}

停止寻呼机（）{
    printf "请输入 PagerMaid 容器的名称："
    读取 -r 容器名称 <&1
    echo "正在关闭 Docker 镜像..."
    如果 docker 检查 $container_name &>/dev/null; 然后
        docker stop "$container_name" &>/dev/null
        回声
        shon_online
    别的
        echo "不存在名为$container_name的容器，退出。"
        1号出口
    菲
}

start_pager () {
    printf "请输入 PagerMaid 容器的名称："
    读取 -r 容器名称 <&1
    echo "正在启动 Docker 容器..."
    如果 docker 检查 $container_name &>/dev/null; 然后
        docker start $container_name &>/dev/null
        回声
        echo "Docker 启动完毕。"
        回声
        shon_online
    别的
        echo "不存在名为$container_name的容器，退出。"
        1号出口
    菲
}

重启寻呼机（）{
    printf "请输入 PagerMaid 容器的名称："
    读取 -r 容器名称 <&1
    echo "正在重新启动Docker容器..."
    如果 docker 检查 $container_name &>/dev/null; 然后
        docker restart $container_name &>/dev/null
        回声
        echo "Docker 重新启动完毕。"
        回声
        shon_online
    别的
        echo "不存在名为$container_name的容器，退出。"
        1号出口
    菲
}

重新安装寻呼机（）{
    清理
    build_docker
    start_docker
    数据持久性
}

shon_online () {
    echo "一键脚本出现任何问题请手动转。com xtaolab"
    echo "一键脚本出现任何问题请手动转。com xtaolab"
    echo "一键脚本出现任何问题请手动转。com xtaolab"
    回声“”
    回声“”
    echo "欢迎使用PagerMaid-Modify Docker一键安装脚本。"
    回声
    echo "请选择您需要进行的操作："
    echo " 1) Docker 安装 PagerMaid"
    echo " 2) Docker 装载 PagerMaid"
    echo "3) Docker 关闭 PagerMaid"
    echo " 4) Docker 启动 PagerMaid"
    echo " 5) Docker 重启 PagerMaid"
    echo "6) Docker 重装PagerMaid"
    echo "7) 将 PagerMaid 数据化持久化"
    echo "8) 退出脚本"
    回声
    echo "版本：0.3.1"
    回声
    echo -n "请输入编号："
    读 N
    案例 $N 在
        1)
            开始安装
            ;;
        2)
            清理
            ;;
        3)
            stop_pager
            ;;
        4)
            start_pager
            ;;
        5)
            restart_pager
            ;;
        6)
            重新安装寻呼机
            ;;
        7)
            数据持久性
            ;;
        8)
            出口 0
            ;;
        *)
            echo "输入错误！"
            睡眠 5s
            shon_online
            ;;
    经社理事会
}

shon_online
