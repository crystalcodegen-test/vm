#!/bin/sh

# change to vm dir
cd /Developer/Atom/vm

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

# validate image
if [ ! "$3" ]; then
	image=image/ubuntu-13.04.vdi
else
	image=image/$3.vdi
fi

# display vm info
echo "\nVM v0.5.0 (beta) - $action\n"
echo "====================\n"

if [ $action == "key" ]; then
	bin/vm/key.sh $1 $2 $3
fi

if [ $action == "launch" ]; then
	bin/vm/launch.sh $2 $3 $4
fi

if [ $action == "log" ]; then
	bin/vm/log.sh $1 $2 $3
fi

if [ $action == "mysql" ]; then
	bin/vm/mysql.sh $1 $2 $3
fi

if [ $action == "pause" ]; then
	bin/vm/pause.sh $1 $2 $3
fi

if [ $action == "reset" ]; then
	bin/vm/reset.sh $1 $2 $3
fi

if [ $action == "resume" ]; then
	bin/vm/resume.sh $1 $2 $3
fi

if [ $action == "ssh" ]; then
	bin/vm/ssh.sh $1 $2 $3
fi

if [ $action == "start" ]; then
	bin/vm/start.sh $1 $2 $3
fi

if [ $action == "stop" ]; then
	bin/vm/stop.sh $1 $2 $3
fi
