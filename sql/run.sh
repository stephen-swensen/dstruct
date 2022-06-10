#!/bin/bash

if [ $# -eq 1 ]; then 
    sqlcmd -S "$DSTRUCT_DB_SERVER" -U "$DSTRUCT_DB_USER" -P "$DSTRUCT_DB_PASSWORD" -i $1
else
    sqlcmd -S "$DSTRUCT_DB_SERVER" -U "$DSTRUCT_DB_USER" -P "$DSTRUCT_DB_PASSWORD"
fi

