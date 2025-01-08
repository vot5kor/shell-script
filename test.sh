#!/bin/bash

LOG_FILE="/var/log/shellscript-log"
FILE_NAME=$(echo $0 | cut -d "." -f1  )
TIMESTAMP=$(date  +%Y-%m-%d:%H-%M-%S)
LOG_FILE_NAME="$LOG_FILE/$FILE_NAME-$TIMESTAMP.log"
echo "test: $LOG_FILE_NAME"
