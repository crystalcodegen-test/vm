#!/bin/sh

if [ ! "$2" ]; then
	machine=default
else
	machine=$2
fi

tail -f /code/default/vm/machine/$machine/log/apache2/error.log
	
exit