#!/bin/bash

sum=0
previousppid=-1
count=0

while read line
do

ppid=$(echo $line | cut -d ":" -f 2 | grep -E -s -o "[0-9]+")
runTime=$(echo $line | cut -d ":" -f 3 | grep -E -s -o "[0-9]+")

if (( previousppid != -1 && ppid != previousppid))
then
echo "Average_Sleeping_Children_of_ParentID=$ppid is" $(echo "scale=2; $sum / $count" | bc -l)
sum=0
count=0
fi

sum=$(echo "scale=2; $sum + $runTime" | bc -l)
previousppid=$ppid
count=$(($count+1))

done < "file4" > "file5"

echo "Average_Sleeping_Children_of_ParentID is" $(echo "scale=2; $sum / $count" | bc -l) >> "file5"
