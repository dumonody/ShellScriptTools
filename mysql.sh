#!/bin/bash

#	下载并安装Mysql的官方的Yum Repository
wget -i -c http://dev.mysql.com/get/mysql57-community-release-el7-10.noarch.rpm

#	执行上面的命令之后，可以直接yum安装了
yum -y install mysql57-community-release-el7-10.noarch.rpm

#	开始安装mysql服务器,这步完成之后会覆盖掉之前的mariadb
yum -y install mysql-community-server

#	启动mysql
systemctl start mysqld

#	获取当前的数据库密码
sqlPasswd=$(grep "password.*root@localhost" /var/log/mysqld.log)
sqlPasswd=${sqlPasswd##*root@localhost: }
echo "您默认的初始密码是：$sqlPasswd"
#	设置验证密码方针，将默认的ON设置为LOW
echo "set global validate_password_policy=0;" > sql.log
mysql -uroot -p$sqlPasswd < sql.log

#	设置验证密码长度，将默认的8设置为4，这里有个特定算法
echo "set global validate_password_length=4;" > sql.log
mysql -uroot -p$sqlPasswd < sql.log

#	经过这两步设置，密码就可以设置得很简单
#	可以通过命令SHOW VARIABLES LIKE 'validate_password%';进行查看

echo
echo
echo
echo
echo


#	输入新的初始密码，否则不能做任何事情，因为MySQL默认必须修改密码之后才能操作数据库

#	设置一个初始密码
read -p "请设置mysql数据库初始密码:" initPassword
echo "您输入的密码是：$initPassword"

#	创建目录/root/secret,以及密码文件mysql_initPassword
mkdir /root/secret/
touch /root/secret/mysql_initPassword

#	保存到mysql_initPassword中
echo "$initPassword" >> /root/secret/mysql_initPassword

#	生成一个新的sql语句，用于修改初始密码
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$initPassword';" > sql.log

#	将sql文件内容导入，完成初始密码的修改，初始密码保存于mysql_password中
mysql -uroot -p$sqlPasswd < sql.log

#	将授权操作语句写入到sql.log文件中
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$initPassword' WITH GRANT OPTION;" > sql.log

#	设置允许远程登录，并具有所有库任何操作权限
mysql -uroot -p$initPassword < sql.log

#	重载授权表
echo "FLUSH PRIVILEGES;" > sql.log
mysql -uroot -p$initPassword < sql.log


#	设置UTF-8字符集，在特定字符串[mysqld]后面添加一行character-set-server=utf8,注意转义字符
sed -i '/\[mysqld\]/a\character-set-server=utf8' /etc/my.cnf
#	可以使用SHOW VARIABLES LIKE 'character%';这条sql语句进行检验

#	设置3306端口开放
firewall-cmd --zone=public --add-port=3306/tcp --permanent 

#	重启防火墙
systemctl restart firewalld

#	重启数据库
systemctl restart mysqld

#	卸载Yum Repository防止数据库自动更新
yum -y remove mysql57-community-release-el7-10.noarch


