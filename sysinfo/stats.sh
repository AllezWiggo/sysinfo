#!/bin/bash

if [ "$#" -ne 1 ]; then 
    echo "Usage: ./stats.sh <base folder location>"
    exit
fi

SYSINFO_HOME=$1
TEST_NAME=$(cat $SYSINFO_HOME/test.cfg | grep TEST_NAME | cut -d'=' -f2)
TS="$(date +'%Y-%m-%d %H:%M:%S')"
DATA_DIR=$(cat $SYSINFO_HOME/test.cfg | grep DATA_DIR | cut -d'=' -f2)

if [ ! -f "$DATA_DIR/$TEST_NAME" ]; then
  mkdir -p "$DATA_DIR/$TEST_NAME"
fi

$SYSINFO_HOME/machine.sh "$DATA_DIR/$TEST_NAME"
$SYSINFO_HOME/fs.sh "$TS" "$DATA_DIR/$TEST_NAME"
$SYSINFO_HOME/top.sh "$TS" "$DATA_DIR/$TEST_NAME"
$SYSINFO_HOME/sys_util.sh "$TS" "$DATA_DIR/$TEST_NAME"
$SYSINFO_HOME/disk.sh "$TS" "$DATA_DIR/$TEST_NAME"

for fl in addons/*.sh
do
  $SYSINFO_HOME/$fl "$TS" "$SYSINFO_HOME" "$DATA_DIR/$TEST_NAME"
done