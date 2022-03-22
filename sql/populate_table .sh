#!/bin/bash

if [ "$#" -ne 1 ]
then
    echo "Usage: ./populate_table.sh  bucket-name"
    exit
fi

BUCKET=$1
echo "Populating Cloud SQL instance flights from gs://${BUCKET}/flights/raw/..."

# the table name for mysqlimport comes from the filename, so rename our CSV files, changing bucket name as needed
counter=0

for FILE in 201501.csv 201507.csv; do
    gsutil cp gs://${BUCKET}/flights/raw/$FILE flights.csv-${counter}
    counter=$((counter+1))
done

# import csv files

cat flights.csv-* | PGPASSWORD=$PASS psql --host=$DBIP --user=postgres -d postgres -c "\copy flights from stdin delimiter ',' csv header;"

rm flights.csv-*