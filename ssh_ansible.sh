#!/bin/bash


HOST=$2
SSH_MIDDLE_MAN="imdsupp@xxx00e2"
HOST_LOWER=`echo $HOST | awk '{print tolower($0) }'`
ANSIBLE_CMD="timeout 120 /usr/bin/ansible $HOST_LOWER -o -m shell -a "

REGEX_ANSIBLE_HOST='lgd[g|p]v[0-9]'

# Build SSH ansible command to run thru ssh middle man

if [[ "$HOST_LOWER" =~ $REGEX_ANSIBLE_HOST ]] 
then
RUN_CMD=`echo "su -l imdsup -c \"$ANSIBLE_CMD '$1' \""`
else
RN_CMD=`echo "ssh -Tq $SSH_MIDDLE_MAN \"$ANSIBLE_CMD '$1' \""`
fi

eval $RUN_CMD | awk -F"|" '{print $4}' | sed s/\(stdout)//g

