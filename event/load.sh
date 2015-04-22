#!/bin/sh

# setup mounts
if [ ! -d "/var/git" ]; then
	mkdir /var/git
	echo "Created /var/git directory."
fi
if [ ! -d "/var/machine" ]; then
	mkdir /var/machine
	echo "Created /var/machine directory."
fi
uid=$(id www-data -u)
gid=$(id www-data -g)
mount -t vboxsf -o uid=$uid,gid=$gid git /var/git
mount -t vboxsf Machine /var/machine
echo "Mounted /var/git and /var/machine."

# log ip
ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{print $1}' >> /var/machine/log/ip

# setup network
if [ -e "/var/machine/ip.ini" ]; then
	file1=/etc/network/interfaces
	file2=/var/machine/ip.ini
	if ! diff $file1 $file2; then
		rm -rf /etc/network/interfaces
		cp /var/machine/ip.ini /etc/network/interfaces
		reboot -f now
		echo "Completed network setup."
	fi
fi

# change to vm dir
cd /vm

# load instance
if [ -e "/var/log/vm.log" ]; then
	echo "Instance already initialized."
	
	# mount data
	uid=$(id mysql -u)
	gid=$(id mysql -g)
	mount -t vboxsf -o uid=$uid,gid=$gid Data /data
	
	# log ip
	ifconfig >> /var/machine/log/ip
	
	# reset www directory
	cd /var/www
	rm *
	
	# machine load
	/var/machine/event/load.sh

# initialize instance
else
	echo "Initializing instance for the first time."
	/vm/event/init.sh >> /var/log/vm.log
fi
