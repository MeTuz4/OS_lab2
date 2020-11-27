#!/bin/bash

case "$1" in
1)
ps -F U user | grep -c user | awk '{print $1}'> file
ps a U user o user,pid,command | grep user | awk '{print $2 ":" $3}' >> file
;;
2)
ps ax o pid,command | grep "/sbin/" | awk '{print $1}'
;;
3)
ps -A o pid,start_time --sort=start_time | tail -n 1 | awk '{print $1}'
;;
4)
for pid in $(ps -A o pid)
do
ppid=$(grep -s "PPid" "/proc/"$pid"/status" | awk '{print "Parent_ProcessID=" $2}')
sum=$(grep -s "sum_exec_runtime" "/proc/"$pid"/sched" | awk '{print $3}')
nr=$(grep -s "nr_switches" "/proc/"$pid"/sched" | awk '{print $3}')
art=$(echo "scale=2; $sum / $nr")
echo "ProcessID=$pid : $ppid : sum=$sum : nr=$nr : art=$art"
done
;;
5)

;;
6)

;;
7)

;;
esac
