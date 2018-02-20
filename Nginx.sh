#!/bin/bash

#	使用yum安装，实质上就是用RPM安装。
#	/etc			一些配置文件的目录，例如/etc/init.d/mysql
#	/usr/bin		一些可执行文件
#	/usr/lib		一些程序使用的动态函数库
#	/usr/share/doc	一些基本的软件使用手册与帮助文档
#	/usr/share/man	一些man page文件


#	先安装gcc
yum install -y gcc-c++

#   安装pcre  和  pcre-devel依赖库
yum install -y pcre pcre-devel

#   安装zlib  和  zlib-devel依赖库
yum install -y zlib zlib-devel

#   安装openssl  和  openssl-devel依赖库
yum install -y openssl openssl-devel

#	下载nginx1.13版本到当前目录
wget -c http://nginx.org/download/nginx-1.13.8.tar.gz

#	解压nginx-1.13.8.tar.gz
tar -zxvf nginx-1.13.8.tar.gz

#	进入nginx-1.13.8.tar.gz
cd nginx-1.13.8

#	使用默认配置
./configure

#	删除下载的nginx-1.13.8的压缩包
rm -f ../nginx-1.13.8.tar.gz

#	编译安装
make
make install

#	获取nginx的位置,放在loc变量中
loc=$(whereis nginx)
loc=${loc:7}

#	进入$loc/sbin/目录中
cd $loc/sbin/

#	先停止nginx--此方式停止步骤是待nginx进程处理任务完毕进行停止
./nginx -s quit

#	启动nginx进程
./nginx

#	设置开机自启动
echo "$loc/sbin/nginx" >> /etc/rc.d/rc.local

#	设置执行权限
chmod 755 /etc/rc.d/rc.local

#	永久开启80端口，若不打开，防火墙会导致nginx默认首页无法访问
firewall-cmd --zone=public --add-port=80/tcp --permanent 

#	重启防火墙
systemctl restart firewalld

#	访问ngnix首页直接访问http://IP:80或者对应的域名即可
