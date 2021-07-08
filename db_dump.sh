#!/bin/bash

database_name=moodle_backup #name of your backup

current_date=`date +%d-%m-%Y_%H-%M`

USER_DUMP= # your sql user of database

PASSWORD_DUMP= # password of this user

ABSOLUTE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/" #Directory where script is located

status_mysql=`systemctl status mysql | grep running`

#====================

backup_name=$database_name"_"$current_date".sql"


if [[ ${#status_mysql} == 0 ]];
then
	echo"MySQL service - not running.Please install in or run it. "
	exit 1
else
	echo "MySql service - running"
fi

dump=`mysqldump -u $USER_DUMP -p$PASSWORD_DUMP moodle > $ABSOLUTE_PATH$backup_name` # Creating backup in dir where script is located

#CRONTAB
#*/1 * * * * {path}/db_dump.sh # dump every minute for test # use pwd in script location
