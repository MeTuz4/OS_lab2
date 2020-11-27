#!/bin/bash

for i in $(ps -A o pid,command | awk '{print $1":"$2}')
do
pid=$(echo $i | cut -d ":" -f 1)
cmd=$(echo $i | cut -d ":" -f 2)
past_read_bytes=$(grep -s "read_bytes" "/proc"$pid"/io" | grep -E -o "[0-9]+")
if [[ -n $past_read_bytes ]]
then
echo "$pid $cmd $past_read_bytes"
fi
done > "temp"
sleep 1m
for i in $(ps -A o pid,command | awk '{print $1":"$2}')
do
pid=$(echo $i | cut -d ":" -f 1)
cmd=$(echo $i | cut -d ":" -f 2)
new_read_bytes=$(grep -s "read_bytes" "/proc/"$pid"/io" | grep -E -o "[0-9]+")
past_read_bytes=$(cat "temp" | grep "$pid" | awk '{print $3}')
if [[ -n $past_read_bytes && -n $new_read_bytes ]]
then
read
read_bytes=$(($new_read_bytes - $past_read_bytes))
echo "PID:$pid CMD:$cmd BYTES:$(($read_bytes))"
fi
done | sort -n -t ':' -k 3 | head -3

rm "temp"
