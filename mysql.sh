#!/bin/bash
# mysql.sh
wget https://raw.githubusercontent.com/dumonody/ShellScriptTools/master/mysql_configure.sh
wget https://raw.githubusercontent.com/dumonody/ShellScriptTools/master/mysql_download.sh
chmod 755 mysql_configure.sh mysql_download.sh
./mysql_download.sh
./mysql_configure.sh
#	清理垃圾文件
rm -f sql.log
rm -f mysql57-community-release-el7-10.noarch.rpm
rm -f mysql_download.sh
rm -f mysql_configure.sh
#	tip
echo "安装完毕！"
