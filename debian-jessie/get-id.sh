#!/bin/bash
shopt -s extglob
if [ -z $1 ] || [ -z $2 ] ; then
errorlevel=1
else
patternrep=$1
patterntag=$2
id=empty
linenumber=2
docker images > /tmp/images-docker.txt
linequantity=$(sed $= -n /tmp/images-docker.txt)
while [[ $linequantity != $linenumber ]]
do
cline=$(sed -n "${linenumber} p" /tmp/images-docker.txt)
cline=${cline//+(  )/;}
cline=${cline%;}
#echo $cline
if [[ "$cline" = *"$patternrep"* && "$cline" = *"$patterntag"* ]]
then
cline=${cline%;*}
cline=${cline%;*}
cline=${cline#*;}
cline=${cline#*;}
id=$cline
fi
linenumber=$(( linenumber + 1 ))
#echo $linequantity
#echo $linenumber
done
errorlevel=$?
fi
echo $id $errorlevel

