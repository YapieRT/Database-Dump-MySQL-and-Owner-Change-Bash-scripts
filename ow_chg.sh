#!/bin/bash

input_user=$1
input_dir=$2

# Костилі

root_flag=""
existUser_flag=""
existDir_flag=""

# Вихід, якщо менше 2 аргументів

if [ $# -ne 2 ]
then
echo "You need to enter 2 arguments user and directory"
exit 1
else
    # Функції для перевірки значень

    function checkRoot {
        if [ $UID -eq 0 ];
        then 
            root_flag="true"
        else 
            root_flag="false"
        fi
    }


    function checkExistingUser {

        getent passwd $input_user >/dev/null

        if [ $? -eq 0 ];  
        then 
            existUser_flag="true"
        else 
            existUser_flag="false"
        fi
    }

    function checkDirectory {
        if [ -d $input_dir ];
        then 
            existDir_flag="true"
        else 
            existDir_flag="false"
        fi
    }

    # Оновлення даних в прапорцях

    checkRoot
    checkExistingUser
    checkDirectory


    if [ "$root_flag" == "true" ];
    then
        if [ "$existUser_flag" == "true" ];
        then
            if [ "$existDir_flag" == "true" ];
            then 
                chown -R $input_user:$input_user $input_dir
                echo "Complete!"
            else
                echo "There is no such directory."
                exit 1
            fi
        else 
            echo "There is no such user."
            exit 1
        fi
    else 
        echo "You need to be root./"
        exit 1
    fi
fi