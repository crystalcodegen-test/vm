#!/bin/sh

# validate action
if [ ! "$1" ]; then
	echo "Action is required"
	exit
fi
action=$1

# validate machine
if [ ! "$2" ]; then
	machine=default
else
	machine=$2
fi

VBoxManage controlvm $machine reset