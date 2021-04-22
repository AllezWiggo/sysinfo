#!/bin/bash
TEST_NAME=$(cat test.cfg | cut -d'=' -f2)
TS="$(date +%d-%b-%Y-%H:%M:%S)"
BASE="/home/centos/sysinfo"
DATA_DIR="$BASE/data/$TEST_NAME"

if [ ! -f $DATA_DIR ]; then
  mkdir -p $DATA_DIR
fi
./machine.sh "$DATA_DIR"
./fs.sh $TS "$DATA_DIR"
./top.sh $TS "$DATA_DIR"
./sys_util.sh "$TS" "$DATA_DIR"
./disk.sh "$TS" "$DATA_DIR"

for fl in addons/*.sh
do
  ./$fl "$TS" "$BASE" "$DATA_DIR"
done