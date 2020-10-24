#!/bin/sh
COMPARTMENT_ID=
AD_NAME=
SUBNET_ID=

for line in `cat ./list.txt |grep -v \#`
do
 INSTANCE_NAME=`echo ${line} | cut -d, -f 1`
 INSTANCE_ID=`echo ${line} | cut -d, -f 2`
 echo -n "Stopping ${INSTANCE_NAME} ..."
 echo    "`LC_ALL=C date "+%Y-%m-%d %H:%M:%S"` - Stopping ${INSTANCE_ID},${INSTANCE_ID} -----" >> stop.log

 oci compute instance action \
 --instance-id ${INSTANCE_ID} \
 --action SOFTSTOP >> stop.log 2>&1

 echo "Done"
 sleep 1

done
