#!/bin/bash

dnf list installed mysql

if [ $? -ne 0 ]
then # not installed
    dnf install mysql -y
    if [ $? -ne 0 ]
    then
        echo "Installing MySQL ... FAILURE"
        exit 1
    else
        echo "Installing MySQL ... SUCCESS"
    fi
else
    echo "MySQL is already ... INSTALLED"
fi

