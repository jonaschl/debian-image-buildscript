#!/bin/bash
shopt -s extglob
patternrep=$1
patterntag=$2
id=empty
linenumber=2
docker images > /tmp/images-docker.txt
linequantity=$(wc -l /tmp/images-docker.txt)

while [[ $linequantity != $linenumber && $id == "empty" ]]
do
cline=$(sed -n "${linenumber} p" /tmp/images-docker.txt)
cline=${cline//+(  )/;}
cline=${cline%;}
if [[ "$cline" = *"$patternrep"* && "$cline" = *"$patterntag"* ]]
then
cline=${cline%;*}
cline=${cline%;*}
cline=${cline#*;}
cline=${cline#*;}
id=$cline
fi
linenumber=$(( linenumber + 1 ))
done
echo "$id"
