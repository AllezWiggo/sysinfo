#!/bin/bash
TS="$1"
FS="$2"
# TOP 5 PROCESSES
if [ ! -f "$FS/utilization.csv" ]; then
echo "util_ts,util_pct_cpu,util_pct_mem" > "$FS/utilization.csv"
fi

CPU=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'` 
FREE_DATA=`free -m | grep Mem` 
CURRENT=`echo $FREE_DATA | cut -f3 -d' '`
TOTAL=`echo $FREE_DATA | cut -f2 -d' '`
RAM=$(echo "scale = 2; $CURRENT/$TOTAL*100" | bc)

echo "$TS,$CPU,$RAM" >> "$FS/utilization.csv"
