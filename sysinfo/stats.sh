#!/bin/bash
####### CHANGE THIS ########
HOME_DIR=/home/centos/sysinfo
############################
TEST_NAME=$(cat $HOME_DIR/test.cfg | grep TEST_NAME | cut -d'=' -f2)
TS="$(date +'%Y-%m-%d %H:%M:%S')"
DATA_DIR=$(cat $HOME_DIR/test.cfg | grep DATA_DIR | cut -d'=' -f2)

if [ ! -f "$DATA_DIR/$TEST_NAME" ]; then
  mkdir -p "$DATA_DIR/$TEST_NAME"
fi

$HOME_DIR/machine.sh "$DATA_DIR/$TEST_NAME"
$HOME_DIR/fs.sh "$TS" "$DATA_DIR/$TEST_NAME"
$HOME_DIR/top.sh "$TS" "$DATA_DIR/$TEST_NAME"
$HOME_DIR/sys_util.sh "$TS" "$DATA_DIR/$TEST_NAME"
$HOME_DIR/disk.sh "$TS" "$DATA_DIR/$TEST_NAME"

for fl in addons/*.sh
do
  $HOME_DIR/$fl "$TS" "$HOME_DIR" "$DATA_DIR/$TEST_NAME"
done