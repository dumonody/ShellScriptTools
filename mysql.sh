#!/bin/bash
# mysql.sh
wget https://raw.githubusercontent.com/dumonody/ShellScriptTools/master/mysql_configure.sh
wget https://raw.githubusercontent.com/dumonody/ShellScriptTools/master/mysql_download.sh
chmod 755 mysql_configure.sh mysql_download.sh
./mysql_download.sh
./mysql_configure.sh
