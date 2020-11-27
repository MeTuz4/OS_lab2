#!/bin/bash

maxpid=-1
maxsize=-1

for pid in $(ps -A o pid)
do
current_size=$(grep -s "VmSize" "/proc/"$pid"/status" | grep -E -o "[0-9]+")
if [[ $current_size -gt $max_size ]]
then
maxpid=$pid
maxsize=$current_size
fi
done

top -p $maxpid -b -n 1 > "temp"

vm_size=$(cat "temp" | grep $maxpid | awk '{print $5}')

echo "PID with max vm_size:$maxpid"
echo "MEM in /proc $maxsize"
echo "MEM in top $vm_size"

rm "temp"
