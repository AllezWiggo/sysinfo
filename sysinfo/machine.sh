#!/bin/bash
FS=$1
MC="$(uname -n)"
UP="$(uptime -p | cut -d' ' -f2-)"
TESTENV=$(cat test.cfg | grep TEST_ENV | cut -d'=' -f2)
IT="n/a"
if [ $TESTENV = "AWS" ]; then
    IT="$(curl http://169.254.169.254/latest/meta-data/instance-type)"
fi
# MACHINE INFORMATION
#if [ ! -f $FS/machine.csv ]; then
echo "machine_name,linux_kernel,linux_distro,architecture,cpu_count,cpu_vendor,cpu_mhz,uptime,instance_type" > $FS/machine.csv
lnkrnl="$(uname -r)"
lndistro="$(cat /etc/*-release | tail -1)"
line="$(lscpu | grep Architecture:)"
IFS=', ' read -r -a array <<< "${line}"
cpuarch="${array[1]}"
line="$(lscpu | grep ^CPU\(s\):)"
IFS=', ' read -r -a array <<< "${line}"
cpucnt="${array[1]}"
line="$(lscpu | grep Vendor\ ID:)"
IFS=', ' read -r -a array <<< "${line}"
cpuvendor="${array[2]}"
line="$(lscpu | grep CPU\ MHz:)"
IFS=', ' read -r -a array <<< "${line}"
cpumhz="${array[2]}"
echo "$MC,$lnkrnl,$lndistro,$cpuarch,$cpucnt,$cpuvendor,$cpumhz,\"$UP\",$IT" >> $FS/machine.csv
#fi

