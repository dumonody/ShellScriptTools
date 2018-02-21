#!/bin/bash
#	mysql_download.sh
#	下载并安装Mysql的官方的Yum Repository
wget -i -c http://dev.mysql.com/get/mysql57-community-release-el7-10.noarch.rpm

#	执行上面的命令之后，可以直接yum安装了
yum -y install mysql57-community-release-el7-10.noarch.rpm

#	开始安装mysql服务器,这步完成之后会覆盖掉之前的mariadb
yum -y install mysql-community-server
