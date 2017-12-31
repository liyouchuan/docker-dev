#!/usr/bin/env bash

#
set -x

#docker pull dhnt/bash

# behind corporate firewall - http_proxy host needs to be ip address
# e.g. export http_proxy=http://10.10.10.10:8080

[ -z "$http_proxy" ] && proxy="" || proxy="-e http_proxy=$http_proxy -e https_proxy=$http_proxy -e no_proxy=$no_proxy"

#
ipaddr=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')

xhost + $ipaddr

export DHNT_BASE=~/.dhnt
export DISPLAY=${ipaddr}:0

docker run --detach $proxy -v ${DHNT_BASE}:/home/vcap -e DISPLAY=${DISPLAY} -it --rm --privileged --name dhnt-bash-$$ dhnt/bash
