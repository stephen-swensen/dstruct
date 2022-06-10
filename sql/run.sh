#!/bin/bash

FILE_ARG=
if [ $# -eq 1 ]; then 
    FILE_ARG="-i$1"
fi

sqlcmd -S "$DSTRUCT_DB_SERVER" -U "$DSTRUCT_DB_USER" -P "$DSTRUCT_DB_PASSWORD" "$FILE_ARG"

