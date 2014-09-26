#!/bin/bash -x

INSTANCE_ID=`curl http://169.254.169.254/latest/meta-data/instance-id 2> /dev/null`
DATETIME=`date '+%Y-%m-%d_%H%M%S'`

aws ec2 create-image --no-reboot --instance-id ${INSTANCE_ID} --name "${INSTANCE_ID}-${DATETIME}"
