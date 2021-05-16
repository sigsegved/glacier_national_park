#!/bin/sh

start=$1
month=$2
end=$3

base_url="https://secure.glaciernationalparklodges.com/lodging/getRooms";

cur=$start
while [ $cur -lt $end ]
do
  start_date="$month/$cur/2021"
  next=$(($cur+1))
  end_date="$month/$next/2021"
  for hotel_code in GLLM GLMG GLRS GLSC GLVI GLCC 
  do
      units_available=`curl -s -G --data-urlencode "hotel_code=$hotel_code" --data-urlencode "dateFrom=$start_date" --data-urlencode "dateTo=$end_date" --data-urlencode "adults=2" --data-urlencode "children=0" $base_url | jq -r '.rateplans.rateplans' | jq length`
      if [ $units_available -gt 0 ];
      then
      	echo "$hotel_code\t$start_date\t$units_available";
      fi
  done
  cur=$next
done

