#!/bin/bash
for pid in $(ps -A o pid)
do
ppid=$(grep -s "PPid" "/proc/"$pid"/status" | awk '{print $2}')
sum=$(grep -s "sum_exec_runtime" "/proc/"$pid"/sched" | awk '{print $3}')
nr=$(grep -s "nr_switches" "/proc/"$pid"/sched" | awk '{print $3}')
if [[ -n $nr ]]
then
art=$(echo "scale=10; $sum / $nr" | bc -l)
echo -e "ProcessID=$pid:Parent_ProcessID=$ppid:Average_Running_Time=$art"
fi
done | sort -n -t = -k 3 > "file4"
