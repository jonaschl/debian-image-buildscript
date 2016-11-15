#!/bin/bash

. /usr/lib/docker-shell-scripts-lib/tag.sh

if [ -z $1 ] ; then
echo "Need a username"
echo "Usage: $0 username"
exit 1
fi

# paramater for build
date=$(date +%Y-%m-%d)
repo="debian-jessie-armv7"
dockertag="new"
username=$1

rm -d -f -r "/tmp/build-$repo-$date"
mkdir -p "/tmp/build-$repo-$date"
(cd "$HOME/docker/contrib" || exit
./mkimage.sh -d "/tmp/build-$repo-$date"  debootstrap --variant=minbase --include=inetutils-ping,iproute2 --components=main   jessie http://ftp.halifax.rwth-aachen.de/debian/)
( cd "/tmp/build-$repo-$date" || exit
tag="${username}/${repo}:${dockertag}"
docker build --no-cache=true -t "$tag" .)

echo $(tag-image "${username}/${repo}")

# cleanup
rm -f -r -d "/tmp/build-$repo-$date/"
