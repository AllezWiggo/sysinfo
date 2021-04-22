#!/bin/bash
TS="$1"
FS=$2
# FILESYSTEM
if [ ! -f $FS/filesystem.csv ]; then
echo "timestamp,parent_filesystem,filesystem_path,mountpoint,filesystem_type,total_1m_blks,used_1m_blks,free_1m_blks" > $FS/filesystem.csv
fi
lsblk -l | while read line
do
IFS=', ' read -r -a array <<< "$line"
if [[ ${array[5]} == "disk" ]]
then
  parentfs="${array[0]}"
else
  if [[ ${array[5]} == "part" && ${array[6]} != "" && ${array[6]} != "[SWAP]" ]]
  then
    dfopline="$(df -mT ${array[6]} | tail -1)"
    IFS=', ' read -r -a dfoparr <<< "${dfopline}"
    echo "$TS,$parentfs,${array[0]},${array[6]},${dfoparr[1]},${dfoparr[2]},${dfoparr[3]},${dfoparr[4]}" >> $FS/filesystem.csv
  fi
fi
done
