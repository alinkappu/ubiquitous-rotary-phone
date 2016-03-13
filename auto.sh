#!/bin/bash
TRANSETF=settings.json
FLEXSETF=config.yml
CRON=/var/spool/cron/crontabs/pi
su
apt-get install python-pip
apt-get install python-dev
apt-get install libevent-dev
pip install -U pip
pip install flexget
apt-get install transmission-daemon
pip install transmissionrpc
service transmission-daemon stop
cp $TRANSETF /etc/transmission-daemon/settings.json
service transmission-daemon start
su pi
cp $FLEXSETF ~/.flexget/config.yml
flexget execute --learn
FlexgetPath=`which flexget`
su
echo "0 0-23 * * * $FlexgetPath execute >>/tmp/flexget.log 2>&1" >> $CRON
apt-get install minidlna
