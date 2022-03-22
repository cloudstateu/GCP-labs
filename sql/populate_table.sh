#!/bin/bash

if [ "$#" -ne 2]
then
    echo "Usage: ./populate_table.sh  database-ip  password"
    exit
fi

SOURCE=$HOME/flights-raw/
echo "Populating Cloud SQL instance flights from $SOURCE"

# the table name for mysqlimport comes from the filename, so rename our CSV files, changing bucket name as needed
# and that's why csvs should be copied

counter=0
FILES="${SOURCE}/*.csv"

DBIP=$1
PASS=$2

for FILE in $FILES; do
    echo "Populating $FILE"
    cp $FILE flights.csv

    cat flights.csv | PGPASSWORD=$PASS psql --host=$DBIP --user=postgres -d postgres -c "\copy flights from stdin delimiter ',' csv header;"
    rm flights.csv
done
