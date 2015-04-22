# vm

## Table of Contents

0. [Commands](#commands)
0. [Creating VM Images](#creating-vm-images)

## <a name="commands"></a> Commands

`vm launch`

Parameters:

- `--image=ubuntu-14.04.1`
- `--machine=default`
- `--memory=2048MB` (Coming Soon)
- `--path=/Developer/Atom/vm`
- `--size=100GB` (Coming Soon)
- `--full-name=Tate` (Coming Soon)
- `--username=tate` (Coming Soon)
- `--password=password` (Coming Soon)

`vm start`

- `--machine=default`

`vm stop`

- `--machine=default`

## <a name="creating-vm-images"></a> Creating VM Images

0. Download ISO file
0. Create new VM
		Name: Ubuntu 14.04.1
		Memory: 2048MB
		Size: 100GB
		Full Name: Tate
		Username: tate
		Password: ****************
		Encrypt Directory: Yes
0. Install OpenSSH Package
0. Install GRUB
0. Install Guest Additions
	0. Install packages
			sudo su
			apt-get update
			apt-get install dkms build-essential -y
	0. Load Guest Additions ISO
	0. Mount ISO
			mount /dev/cdrom /media/cdrom
	0. Run ISO
			cd /media/cdrom
			./VBoxLinuxAdditions.run
0. Create VM directory
		mkdir /vm
0. Update /etc/rc.local:
		mount -t vboxsf VM /vm
		chmod 777 /vm/event/load.sh
		/vm/event/load.sh
0. Shutdown VM
		shutdown now
