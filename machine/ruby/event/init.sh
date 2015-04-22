rm /etc/resolv.conf
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf

#apt-get update
#apt-get install libmysqlclient-dev

# install rvm
#\curl -sSL https://get.rvm.io | bash -s stable --rails
#source /usr/local/rvm/scripts/rvm

# install gems
#gem install goliath
#gem install grape
#gem install rack
#gem install mysql2

# rename hostname
rm /etc/hostname
echo "ruby" >> /etc/hostname
reboot -f now