# ShellScriptTools,针对CentOS7环境的一些脚本
### nginx一键安装脚本，对应nginx版本为1.13.8

## CentOS 7  安装  MySQL5.7.21
**简单说明**
- 开放3306端口，不关闭防火墙
- 直接覆盖掉CentOS7自带的MariaDB
- 同时帮助设置了远程登录
- 自定义初始密码，并在/root/secret/mysql_initPassword文件中可以查看到
- 安装命令如下：
```
wget https://raw.githubusercontent.com/dumonody/ShellScriptTools/master/mysql.sh&&chmod 755 mysql.sh&&./mysql.sh
```
