#!/bin/bash

SOURCE_DIRECTORY="/home/ec2-user/app-logs"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ -d $SOURCE_DIRECTORY ]
then
    echo -e "$G Source directory exists $N"
else
    echo -e "$R Please make sure $SOURCE_DIRECTORY exists $N"
    exit 1
fi

FILES=$(find $SOURCE_DIRECTORY -name "*.log" -mtime +14)
echo "Files to be deleted: $FILES"

# while IFS= read -r line
while read -r line
do
    
    rm -rf $line
    echo "Deleted files: $line"
done <<< $FILES