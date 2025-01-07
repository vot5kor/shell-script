#!/bin/bash 

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"

VALIDATE()
{
             if [ $1 -ne 0 ]
                then # not Installed
                echo -e "$2 ... $R FAILED $N"
                exit 1
                else
                 echo -e "$2 ... $G SUCCESSFULLY $N"
            fi
}


if [ $USERID -ne 0 ]
then
    echo "ERROR:: You must have sudo access to execute this script"
    echo "test: $USERID"
    exit 1 #other than 0
fi

dnf list installed git -y

if [ $? -ne 0 ]
    then #not Installed
    dnf install git1 -y
    VALIDATE $? "Installing GIT"
    # if [ $? -ne 0 ]
        # then # not Installed
        # echo "Installing GIT ... FAILED"
        # exit 1
        # else
        # echo "Installing GIT ... SUCCESSFULLY"
    # fi
else
echo -e "GIT Already ... $Y INSTALLED $N"
fi

dnf list installed mysql
if [ $? -ne 0 ]
then # not installed
    dnf install mysql -y
    VALIDATE $? "Installing MYSQL"
    # if [ $? -ne 0 ]
        # then
        # echo "Installing MYSQL ....FAILED"
        # exit 1 
        # else
        # echo "Installing MYSQL ....SUCCESSFULLY"
    # fi
    else
    echo -e "MYSQL Already... $Y INSTALLED $N"
fi


