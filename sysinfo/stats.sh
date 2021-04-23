#!/bin/bash
TEST_NAME=$(cat test.cfg | grep TEST_NAME | cut -d'=' -f2)
TS="$(date +'%Y-%m-%d %H:%M:%S')"
HOME_DIR=$(cat test.cfg | grep HOME_DIR | cut -d'=' -f2)
DATA_DIR=$(cat test.cfg | grep DATA_DIR | cut -d'=' -f2)

if [ ! -f "$DATA_DIR/$TEST_NAME" ]; then
  mkdir -p "$DATA_DIR/$TEST_NAME"
fi

./machine.sh "$DATA_DIR/$TEST_NAME"
./fs.sh "$TS" "$DATA_DIR/$TEST_NAME"
./top.sh "$TS" "$DATA_DIR/$TEST_NAME"
./sys_util.sh "$TS" "$DATA_DIR/$TEST_NAME"
./disk.sh "$TS" "$DATA_DIR/$TEST_NAME"

for fl in addons/*.sh
do
  ./$fl "$TS" "$HOME_DIR" "$DATA_DIR/$TEST_NAME"
done