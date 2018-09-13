#!/bin/bash

## It is much faster to download with curl

URL='http://www.nyc.gov/html/tlc/html/about/trip_record_data.shtml'

## To download all
#YELLOW_CSV=$(curl -s $URL | grep yellow_tripdata | sed 's/.*href="//' | sed 's/".*//')

## To download March, June, November 2017
YELLOW_CSV=$(curl -s $URL | grep -E 'yellow_tripdata_2017-(03|06|11)' | sed 's/.*href="//' | sed 's/".*//')
echo $YELLOW_CSV

for file in $YELLOW_CSV; do
  echo $file
  name=$(echo $file | cut -d'/' -f 6)
  curl $file -o $name
done

NUMBER_DOWNLOADED=$(ls *.csv | wc -l)
NUMBER_YELLOW=$(echo $YELLOW_CSV | wc -l)

if [ $NUMBER_DOWNLOADED -eq $NUMBER_YELLOW ]
then
  echo "All downloaded"
else
  echo "Not all files downloaded"
fi
