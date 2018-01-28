#!/bin/bash

az=$1
if [[ -z "${az}" ]]; then
    echo "Provide availability zone as argument."
    exit 1
fi

echo "Checking availability zone $az"

region=$(echo $az | rev | cut -c 2- | rev)
raw=$(aws ec2 describe-reserved-instances-offerings --filters "Name=availability-zone,Values=$az"  --region $region)
instance_types=$(echo $raw | jq '.ReservedInstancesOfferings[] | .InstanceType' | sort -u)

while read -r instance_type; do
  echo "$region $az $instance_type"
done <<< "$instance_types"
