#!/bin/bash 

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR:: You must have sudo access to execute this script"
    echo "test: $USERID"
    exit 1 #other than 0
fi

dnf list installed mysql
if [ $? -ne 0 ]
then # not installed
    dnf install mysql -y
    if [ $? -ne 0 ]
        then
        echo "Installing MYSQL ....FAILED"
        exit 1 
        else
        echo "Installing MYSQL ....SUCCESSFULLY"
    fi
    else
    echo "MYSQL Already... INSTALLED"
fi


dnf list installed git -y

if [ $? -ne 0 ]
    then #not Installed
    dnf install git -y
    if [$? -ne 0 ]
        then # not Installed
        echo "Installing GIT ... FAILED"
        exit 1
        else
        echo "Installing GIT ... SUCCESSFULLY"
    fi
else
echo "GIT Already ... INSTALLED"
fi