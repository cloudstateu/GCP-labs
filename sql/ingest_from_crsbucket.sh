#!/bin/bash

FROM=gs://data-science-on-gcp/edition2/flights/raw
TO=$HOME/flights-raw/

echo "Downloading data to $TO"
mkdir $TO

CMD="gsutil -m cp "

for MONTH in `seq -w 1 12`; do
  CMD="$CMD ${FROM}/2015${MONTH}.csv"
done

CMD="$CMD ${FROM}/201601.csv $TO"
echo $CMD
$CMD