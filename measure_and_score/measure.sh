#!/bin/bash -x

if [ `whoami` == 'root' ]; then exit 1; fi

. env.sh

cd ${CONFIGDIR}

sudo mkdir -p ${CONFIGDIR}/
sudo mkdir -p ${CONFIGDIR}/files

if [ ! -e ${CONFIGDIR}/.git ]; then git init ; fi

sudo sync; sudo sync; sudo sync;
sudo sh -c "echo 3  > /proc/sys/vm/drop_caches"
sudo sh -c "echo "" > /var/log/nginx/access.log"
sudo sh -c "echo "" > /var/log/nginx/error.log"
sudo sh -c "echo "" > /var/log/mysqld.log"

sudo /etc/init.d/nginx  restart
sudo /etc/init.d/mysqld restart

RESULT=`sh /tmp/measure.sh`

DATETIME=`date '+%Y-%m-%d_%H%M%S'`

cd ${CONFIGDIR}
sudo mkdir -p ${CONFIGDIR}/files/${DATETIME}
sudo cp -ar /var/log/nginx/access.log ${CONFIGDIR}/files/${DATETIME}
sudo cp -ar /var/log/nginx/error.log  ${CONFIGDIR}/files/${DATETIME}
sudo cp -ar /var/log/mysqld.log       ${CONFIGDIR}/files/${DATETIME}

sudo git add -A
sudo git commit -m "fin. ${RESULT}"
