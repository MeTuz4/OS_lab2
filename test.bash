#!/bin/bash
for pid in $(ps -A o pid)
do

ppid=$(grep -s "PPid" "/proc/"$pid"/status" | awk '{print $2}')
sum=$(grep -s "sum_exec_runtime" "/proc/"$pid"/sched" | awk '{print $3}')
nr=$(grep -s "nr_switches" "/proc/"$pid"/sched" | awk '{print $3}')

echo "ProcessID=$pid : ppid=$ppid : sum=$sum : nr=$nr"
done
