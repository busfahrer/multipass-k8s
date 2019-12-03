#!/bin/sh
# usage: ./action.sh <action> <count>
# e.g.: ./action.sh delete 3

ACTION=$1
COUNT=${2:-3}

echo Performing action $ACTION on $COUNT nodes...

for i in `seq 1 $COUNT`
do
  echo $ACTION node$i...
  multipass $ACTION node$i
done
