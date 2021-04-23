#!/bin/bash
TS=$1
FN="$(date +%d-%b-%Y-%H%M%S)"
BASE=$2
DATA_DIR=$3
TMP="$BASE/data/tmp"
URL=$(cat as4.cfg | grep AS4_URL | cut -d'=' -f2)
GRID=$(cat as4.cfg | grep AS4_GRID_NAME | cut -d'=' -f2)
/opt/tibco/as/4.6/bin/tibdg -r $URL -g $GRID status > $TMP/$FN.log

KEEPER=$(cat $BASE/grid.cfg | grep keeper | cut -d'=' -f2)
PROXY=$(cat $BASE/grid.cfg | grep proxy | cut -d'=' -f2)
NODE=$(cat $BASE/grid.cfg | grep node | cut -d'=' -f2)

if [ ! -f $DATA_DIR/node.csv ]; then
echo "timestamp,name,host,pid,rev,state,txns,reqs,copyset,role,est_size,fs_used,fs_cap,data_dir,max_write" > $DATA_DIR/node.csv
fi

for node in $(seq 1 $NODE);
do
    line=$(cat $TMP/$FN.log | grep psa_node_$node)
    IFS=', ' read -r -a array <<< "$line"
    echo "$TS,${array[1]},${array[2]},${array[3]},${array[4]},${array[5]},${array[6]},${array[7]},${array[8]},${array[9]},${array[10]},${array[11]},${array[12]},${array[13]},${array[14]}" >> $DATA_DIR/node.csv
done

if [ ! -f $DATA_DIR/proxy.csv ]; then
echo "timestamp,name,host,pid,rev,state,clients,req,txn,iter,stmt,qry,lsnr,mode" > $DATA_DIR/proxy.csv
fi

for proxy in $(seq 1 $PROXY);
do
    line=$(cat $TMP/$FN.log | grep psa_proxy_$proxy)
    IFS=', ' read -r -a array <<< "$line"
    echo "$TS,${array[1]},${array[2]},${array[3]},${array[4]},${array[5]},${array[6]},${array[7]},${array[8]},${array[9]},${array[10]},${array[11]},${array[12]},${array[13]}" >> $DATA_DIR/proxy.csv
done

if [ ! -f $DATA_DIR/keeper.csv ]; then
echo "timestamp,name,host,pid,rev,state,role,state_dir" > $DATA_DIR/keeper.csv
fi

for keeper in $(seq 1 $KEEPER);
do
    line=$(cat $TMP/$FN.log | grep psa_keeper_$keeper)
    IFS=', ' read -r -a array <<< "$line"
    echo "$TS,${array[1]},${array[2]},${array[3]},${array[4]},${array[5]},${array[6]},${array[7]}" >> $DATA_DIR/keeper.csv
done


