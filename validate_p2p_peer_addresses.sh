#!/bin/bash

echo "CHECKING PEERS"
for _host in $(cat config.ini | grep "^p2p-peer-address" | awk -F "=" '{print $2}');do
hostp=`echo "$_host" | sed "s/:/\ /"`
b=$(nc -w 1 -zv $hostp 2>&1);
if [[ "$b" == *"timed out"* ]];then
    sed -i "/$_host/s/^/#/g" ./config.ini
    echo "Commented $_host"
fi
done
