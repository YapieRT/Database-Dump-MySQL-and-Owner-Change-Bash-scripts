#!/bin/bash

database_needed_to_be_dumped=moodle # database that you need to backup

database_backup_name=moodle_backup #name of your backup

USER_DUMP= # your sql user of database

PASSWORD_DUMP= # password of this user

current_date=`date +%d-%m-%Y_%H-%M`

ABSOLUTE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/" #Directory where script is located 

status_mysql=`systemctl status mysql | grep running`

#====================

backup_name=$database_backup_name"_"$current_date".sql"


if [[ ${#status_mysql} == 0 ]];
then
	echo"MySQL service - not running.Please install in or run it. "
	exit 1
else
	echo "MySql service - running"
fi

dump=`mysqldump --single-transaction -u $USER_DUMP -p$PASSWORD_DUMP $database_needed_to_be_dumped > $ABSOLUTE_PATH$backup_name` # Creating backup in dir where script is located

#CRONTAB
#*/1 * * * * {path}/db_dump.sh # dump every minute for test # use pwd in script location
