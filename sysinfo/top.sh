#!/bin/bash
TS="$1"
FS=$2
US="centos"
# TOP 5 PROCESSES
if [ ! -f $FS/top.csv ]; then
echo "timestamp,user,pid,command,pct_cpu,pct_mem,thread_count" > $FS/top.csv
fi

#ps aux | sort -rk 3,3 | head -n 6 | tail -n 5 | while read line
ps aux | sed 1d | while read line
do
  IFS=', ' read -r -a array <<< "$line"

#  c1=`echo "${array[2]} < 10.0" | bc -l`
#  c2=`echo "${array[3]} < 10.0" | bc -l`
#  if [ "$c1" -eq "1" ] && [ "$c2" -eq "1" ]; then
#    continue
#  fi
#  if [ "${array[0]}" = "$US" ]; then
    tLen=${#array[@]}
    sCmd=""
    for (( i=10; i<${tLen}; i++ ));
    do
      sCmd="$sCmd ${array[${i}]}"
    done
    TC=$(ps -T ${array[1]} | sed 1d | wc -l)
    echo "$TS,${array[0]},${array[1]},$sCmd,${array[2]},${array[3]},$TC" >> $FS/top.csv
#  fi
done
