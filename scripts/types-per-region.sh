#!/bin/bash

region=$1
if [[ -z "${region}" ]]; then
    echo "Provide region as argument."
    exit 1
fi

echo "Checking availability zones in $region..."
all_az=()

az_region=$(aws ec2 describe-availability-zones --region $region --query 'AvailabilityZones[*].[ZoneName]' --output text | sort)

while read -r az; do
  all_az+=($az)
done <<< "$az_region"

counter=1
num_az=${#all_az[@]}

for az in "${all_az[@]}"
do
  echo "Checking availability zone $az ($counter/$num_az)"

  region=$(echo $az | rev | cut -c 2- | rev)
  raw=$(aws ec2 describe-reserved-instances-offerings --filters "Name=availability-zone,Values=$az"  --region $region)
  instance_types=$(echo $raw | jq '.ReservedInstancesOfferings[] | .InstanceType' | sort -u)

  while read -r instance_type; do
    echo "$region $az $instance_type"
  done <<< "$instance_types"

  counter=$((counter+1))
done 
