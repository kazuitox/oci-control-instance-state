#!/bin/sh
COMPARTMENT_ID=
AD_NAME=
SUBNET_ID=
# PROVISIONING or RUNNING
WAIT_STATE=PROVISIONING

for line in `cat ./list.txt |grep -v \#`
do
 INSTANCE_NAME=`echo ${line} | cut -d, -f 1`
 SHAPE=`echo ${line} | cut -d, -f 2`
 PRIVATE_IP=`echo ${line} | cut -d, -f 3`
 IMAGE_ID=`echo ${line} | cut -d, -f 4`

 echo -n "Launching ${INSTANCE_NAME} ..."
 echo    "`LC_ALL=C date "+%Y-%m-%d %H:%M:%S"` - Launching ${INSTANCE_NAME} -----" >> launch.log

 oci compute instance launch \
 --compartment-id ${COMPARTMENT_ID} \
 --display-name ${INSTANCE_NAME} \
 --availability-domain ${AD_NAME} \
 --source-boot-volume-id ${IMAGE_ID} \
 --assign-public-ip false \
 --shape ${SHAPE} \
 --subnet-id ${SUBNET_ID} \
 --private-ip ${PRIVATE_IP} \
 --wait-for-state ${WAIT_STATE} >> launch.log 2>&1

 sleep 1
 echo "Done"

done
