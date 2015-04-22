# sync code
rm /root/.bash_aliases
echo "alias tate='cd /var/git/tate ; php Tate.php'" >> /root/.bash_aliases
echo "export PATH=/var/machine/bin:$PATH" >> /root/.bash_aliases
source /root/.bashrc

# start redis
redis-server

echo "Done"
