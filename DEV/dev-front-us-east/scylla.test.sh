#!/bin/bash

echo Start
while [ $(nodetool status | grep 'UN ' | grep 'rack-dev-eu-west\|rack-dev-us-east' | wc -l) != [2] ];
do
    echo -n .
    sleep 1
done
echo DONE