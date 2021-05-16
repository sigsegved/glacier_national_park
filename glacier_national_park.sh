#!/bin/bash

start=$1
month=$2
end=$3
profile=$4
targe_arn=$5

base_url="https://secure.glaciernationalparklodges.com/lodging/getRooms";
date=`date`
echo $date >> gnp.log

cur=$start
rm gnp_output
while [ $cur -lt $end ]
do
  start_date="$month/$cur/2021"
  next=$(($cur+1))
  end_date="$month/$next/2021"
  for hotel_code in GLLM GLMG GLRS GLSC GLVI GLCC 
  do
      units_available=`curl -s -G --data-urlencode "hotel_code=$hotel_code"\
	               	--data-urlencode "dateFrom=$start_date"\
			--data-urlencode "dateTo=$end_date"\
			--data-urlencode "adults=2"\
			--data-urlencode "children=0"\
			$base_url | jq -r '.rateplans.rateplans' | jq length`
      if [ $units_available -gt 0 ];
      then
        echo "$hotel_code $start_date $units_available" >> gnp_output
        echo "$hotel_code $start_date $units_available" >> gnp.log
      fi
  done
  cur=$next
done

if [ -n "${profile}" ] && [ -n $topic_arn ] && [ -e gnp_output ];
then
    echo "sending sns notification" >> gnp.log
    aws --profile $profile sns publish --topic-arn $targe_arn --message file://gnp_output
elif [ -e gnp_output ];
then 
    cat gnp_output
fi

if [ -e gnp_output ];
then
    rm -rf gnp_output
fi

echo "---------------------------" >> gnp.log
