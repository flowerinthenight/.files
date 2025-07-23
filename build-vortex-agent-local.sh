#!/bin/sh

# Local build only; environment specific.
docker build --rm -t vortex-agent .
docker tag vortex-agent asia.gcr.io/mobingi-main/vortex-agent:$1
docker push asia.gcr.io/mobingi-main/vortex-agent:$1
docker rmi $(docker images --filter "dangling=true" -q --no-trunc) -f
