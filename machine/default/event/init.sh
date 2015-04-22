# install pecl
#pecl=$(cat /var/machine/pecl.ini)
#pecl install $pecl

# update include_path
echo "include_path=/var/git/tate-lib/dist" >> /etc/php5/apache2/php.ini

# add php extensions
echo "extension=http.so;" >> /etc/php5/apache2/php.ini
echo "extension=oauth.so;" >> /etc/php5/apache2/php.ini

# rename hostname
rm /etc/hostname
echo "default" >> /etc/hostname
echo "127.0.0.1	default" >> /etc/hosts
ifdown eth0 && ifup eth0
