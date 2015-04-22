#!/bin/sh

# disable interactive
export DEBIAN_FRONTEND=noninteractive

# enable private key
mkdir /root/.ssh
cp /var/machine/key/root.key /root/.ssh/authorized_keys
chmod -R 700 /root/.ssh
chmod -R 600 /root/.ssh/authorized_keys

# install aptitude packages
apt-get update
apt=$(cat /var/machine/apt.ini)
apt-get install $apt -y

# install pear extensions
pear=$(cat /var/machine/pear.ini)
pear install $pear

# install pecl extensions
pecl=$(cat /var/machine/pecl.ini)
yes '' | pecl install $pecl

# enable apache modules
a2enmod rewrite
a2enmod vhost_alias

# setup apache vhosts
echo "" >> /etc/apache2/apache2.conf
echo "# setup vhosts" >> /etc/apache2/apache2.conf
echo "UseCanonicalName Off" >> /etc/apache2/apache2.conf
echo "VirtualDocumentRoot /var/www/%0" >> /etc/apache2/apache2.conf
echo "" >> /etc/apache2/apache2.conf
echo "<Directory />" >> /etc/apache2/apache2.conf
echo "        RewriteEngine On" >> /etc/apache2/apache2.conf
echo "        RewriteRule !(favicon\.ico|robots\.txt|img|index\.php|static|test) /index.php" >> /etc/apache2/apache2.conf
echo "</Directory>" >> /etc/apache2/apache2.conf

# setup grub
echo "GRUB_HIDDEN_TIMEOUT=0" >> /etc/default/grub
echo "GRUB_TIMEOUT=0" >> /etc/default/grub

# setup mysql
sed -i 's/bind\-address/#bind-address/g' /etc/mysql/my.cnf

# setup php config
while read config; do
	echo $config >> /etc/php5/apache2/php.ini
	echo $config >> /etc/php5/cli/php.ini
done < /var/machine/php.ini

# setup cron jobs
echo "*/1 * * * * root /vm/event/data.sh" >> /etc/crontab

# add machine bin to path
echo "export PATH=/var/machine/bin:$PATH" >> /root/.bash_aliases
source /root/.bashrc

# include machine events
chmod 755 /var/machine/event/init.sh
chmod 755 /var/machine/event/load.sh
/var/machine/event/init.sh
/var/machine/event/load.sh

# restart services
service apache2 restart
service mysql restart
service ssh restart

# setup hostname
if [ -f /var/machine/hostname.ini ]; then
	rm /etc/hostname
	echo $(cat /var/machine/hostname.ini) >> /etc/hostname
	ifdown eth0 && ifup eth0
fi

echo "VM is ready"

# reboot vm
reboot now
