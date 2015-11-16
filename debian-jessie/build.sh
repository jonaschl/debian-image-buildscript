#!/bin/bash
if [ -z $1 ] ; then
errorlevel=1
else
date=$(date +%Y-%m-%d)
username=$1
rm -d -f -r "/tmp/build-debian-jessie-armv7-$date"
mkdir -p "/tmp/build-debian-jessie-armv7-$date"
(cd "$HOME/docker/contrib" || exit
./mkimage.sh -d "/tmp/build-debian-jessie-armv7-$date"  debootstrap --variant=minbase --include=inetutils-ping,iproute2 --components=main   jessie http://ftp.halifax.rwth-aachen.de/debian/)
( cd "/tmp/build-debian-jessie-armv7-$date" || exit
tag="${username}/debian-jessie-armv7:new"
docker build --no-cache=true -t "$tag" .)
# cleanup
rm -f -r -d /tmp/build-debian-jessie-armv7-$date/
errorlevel=$?
echo $errorlevel
fi
