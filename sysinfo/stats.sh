#!/bin/bash
TEST_NAME=$(cat test.cfg | grep TEST_NAME | cut -d'=' -f2)
TS="$(date +'%Y-%m-%d %H:%M:%S')"
DATA_BASE=$(cat test.cfg | grep DATA_DIR | cut -d'=' -f2)
DATA_DIR="$DATA_BASE/$TEST_NAME"

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