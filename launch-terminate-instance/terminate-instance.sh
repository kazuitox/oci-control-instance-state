#!/bin/sh
COMPARTMENT_ID=
AD_NAME=

for line in `cat ./list.txt |grep -v \#`
do
 INSTANCE_NAME=`echo ${line} | cut -d, -f 1`

 echo -n "Terminating ${INSTANCE_NAME} ..."
 echo    "`LC_ALL=C date "+%Y-%m-%d %H:%M:%S"` - Terminating ${INSTANCE_NAME} -----" >> terminate.log

 INSTANCE_ID=$(oci compute instance list --lifecycle-state RUNNING --compartment-id ${COMPARTMENT_ID} --display-name ${INSTANCE_NAME} --query 'data[0]."id"' --raw-output)

 oci compute instance terminate \
 --instance-id ${INSTANCE_ID} \
 --preserve-boot-volume true \
 --force >> terminate.log 2>&1

 sleep 1
 echo "Done"

done
