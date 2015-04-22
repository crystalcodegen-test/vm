#!/bin/sh

# validate machine
if [ ! "$2" ]; then
	machine=default
else
	machine=$2
fi

key=$(cat /code/default/vm/machine/$machine/key/root.pem)
echo "$key\n"

exit
