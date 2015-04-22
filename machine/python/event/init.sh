#apt-get update
#apt-get install mysql-server python-dev libmysqlclient-dev -y --force-yes

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
echo "python" >> /etc/hostname
reboot -f now