#!/bin/bash
TS="$1"
FS="$2"

if [ ! -f "$FS/disk.csv" ]; then
echo "timestamp,disk,tps,kb_read_per_sec,kb_write_per_sec,kb_read,kb_write" > "$FS/disk.csv"
fi

iostat -d | sed 1d | sed 1d | sed 1d | while read line
do
  IFS=', ' read -r -a array <<< "$line"
  tLen=${#array[@]}
  if [[ ${array[0]} != "" ]]; then
    echo "$TS,${array[0]},${array[1]},${array[2]},${array[3]},${array[4]},${array[5]}" >> "$FS/disk.csv"
  fi
done

