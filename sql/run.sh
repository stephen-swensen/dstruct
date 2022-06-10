#!/bin/bash

sqlcmd -S "$DSTRUCT_DB_SERVER" -U "$DSTRUCT_DB_USER" -P "$DSTRUCT_DB_PASSWORD" -i $1
