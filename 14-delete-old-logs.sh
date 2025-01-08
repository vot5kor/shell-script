#!/bin/bash 

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG_FILE="/var/log/shellscript-log"
FILE_NAME=$(echo $0 | cut -d "." -f1  )
TIMESTAMP=$(date  +%Y-%m-%d:%H-%M-%S)
LOG_FILE_NAME="$LOG_FILE/$FILE_NAME-$TIMESTAMP.log"
echo "test: $LOG_FILE_NAME" &>>$LOG_FILE_NAME

SOURCE_DIR="/home/ec2-user/app-logs"

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

echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME

CHECK_ROOT(){
if [ $USERID -ne 0 ]
then
    echo "ERROR:: You must have sudo access to execute this script"
    echo "test: $USERID"
    exit 1 #other than 0
fi
}

FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -mtime +14)
echo "test: $FILES_TO_DELETE"