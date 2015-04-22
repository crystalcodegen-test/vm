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

# validate path
if [ ! "$3" ]; then
	machine_path=/Developer/Atom/vm/default
else
	machine_path=$3
fi

VBoxManage startvm $machine --type headless

# detect ip
printf "Waiting for IP..."
if [ -f $machine_path/log/ip ]; then
	rm $machine_path/log/ip
fi
while [ ! -f "$machine_path/log/ip" ]; do
	printf "."
	sleep 1
done

# display new ip
echo "Got IP:"
cat $machine_path/log/ip
