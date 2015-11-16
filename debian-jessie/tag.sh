#!/bin/bash
errorlevel=0
# check if we get a username
if [ -z "$1" ]; then
#set the errorlevel to 1, because we have no username
errorlevel=1
else
username=$1
date=$(date +%Y-%m-%d)
patternrep="$username/debian-jessie-armv7"
patterntag="$date"
# get id of the image from today
back=$(./get-id.sh $patternrep $patterntag)
set $back
id=$1
backerrorlevel=$2
	# check if the get-id script finish with errorlevel 0
	if [ "$backerrorlevel" = "0" ] ; then
		# the id is empty
        if [ "$id" = "empty" ] ; then
        # get the id from the new image
		patternrep="$username/debian-jessie-armv7"
		patterntag="new"
		back=$(./get-id.sh $patternrep $patterntag)
		set $back
		id=$1
		backerrorlevel=$2
			# check if the get-id script finish with errorlevel 0
			if [ "$backerrorlevel" = "0" ] ; then
			# rmi the tag latest
			docker rmi "$username/debian-jessie-armv7:latest"
			# tag the new immage with the date from today and latest
			docker tag "$id" "$username/debian-jessie-armv7:latest"
			docker tag "$id" "$username/debian-jessie-armv7:$date"
			# rmi the tag new 
			docker rmi "$username/debian-jessie-armv7:new"
			else
			#set errorlevel to 1, because the call of the get id script in line 23 do not finish with errorlevel=0
			errorlevel=1
			fi				
		else
		# the id is != empty
		patternrep="$username/debian-jessie-armv7"
		patterntag="new"
		back=$(./get-id.sh $patternrep $patterntag)
		set $back
		id=$1
		backerrorlevel=$2
		# check if the get-id script finish with errorlevel 0
			if [ "$backerrorlevel" = "0" ] ; then
			# rmi the image with the tag latest and $date
			docker rmi "$username/debian-jessie-armv7:latest"
			docker rmi "$username/debian-jessie-armv7:$date"
			#tag the new image with latest and date
			docker tag "$id" "$username/debian-jessie-armv7:latest"
			docker tag "$id" "$username/debian-jessie-armv7:$date"
			# rmi the tag new
			docker rmi "$username/debian-jessie-armv7:new"
			else
			#set errorlevel to 1, because the call of the get id script in line 43 do not finish with errorlevel=0
			errorlevel=1
			fi 
        fi
	else
	#set errorlevel to 1, because the call of the get id script in line 12 do not finish with errorlevel=0
	errorlevel=1
	fi
fi
#echo errorlevel
echo $errorlevel
