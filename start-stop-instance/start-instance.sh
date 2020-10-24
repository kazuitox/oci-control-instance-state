#!/bin/sh
COMPARTMENT_ID=
AD_NAME=
SUBNET_ID=
# STARTING or RUNNING
WAIT_STATE=STARTING

for line in `cat ./list.txt |grep -v \#`
do
 INSTANCE_NAME=`echo ${line} | cut -d, -f 1`
 INSTANCE_ID=`echo ${line} | cut -d, -f 2`
 echo -n "Starting ${INSTANCE_NAME} ..."
 echo    "`LC_ALL=C date "+%Y-%m-%d %H:%M:%S"` - Starting ${INSTANCE_NAME},${INSTANCE_ID} ----" >> start.log

 oci compute instance action \
 --instance-id ${INSTANCE_ID} \
 --wait-for-state ${WAIT_STATE} \
 --action START >> start.log 2>&1

 sleep 1
 echo "Done"

done
