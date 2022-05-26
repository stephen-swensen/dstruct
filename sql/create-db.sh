# todo: run on all files *.sql ordered lexicographically
sqlcmd -S "$DSTRUCT_DB_SERVER" -U "$DSTRUCT_DB_USER" -P "$DSTRUCT_DB_PASSWORD" -i 001-create-db.sql
