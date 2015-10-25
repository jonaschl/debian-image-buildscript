#!/bin/bash
patternrep="jonatanschlag/debian-jessie-armv7"
patterntag="2015-10-24"
var=$(./get-id.sh $patternrep $patterntag)
echo "id=$var"
