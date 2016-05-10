FILE=/ssh/id_rsa

if [ -f $FILE ];
then
cp $FILE /home/vagrant/.ssh/id_rsa
chown vagrant:vagrant /home/vagrant/.ssh/id_rsa
chmod 600 /home/vagrant/.ssh/id_rsa
fi

if [ -e /home/vagrant/.bashrc.bak ];
then
cp /home/vagrant/.bashrc.bak /home/vagrant/.bashrc
fi

if [ -e /home/vagrant/.bashrc ];
then
cp /home/vagrant/.bashrc /home/vagrant/.bashrc.bak
fi

echo "alias cdr='cd /home/apps/clarussoftware.co.uk/current/'; cd /home/apps/clarussoftware.co.uk/current" >> /home/vagrant/.bashrc