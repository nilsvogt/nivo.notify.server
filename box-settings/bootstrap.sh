#! /usr/bin/env bash

# assign the root directory of your server
document_root="/vagrant/app/public"

apt-get update

# install server (nginx)
sudo apt-get install -y nginx

# set nginx config
sudo rm /etc/nginx/sites-available/default
sudo cp /vagrant/box-settings/nginx.default /etc/nginx/sites-available/default

# link document root
if ! [ -L /usr/share/nginx/html ]; then
  rm -rf /usr/share/nginx/html
  ln -fs ${document_root} /usr/share/nginx/html
fi

# install php 5 stack
sudo apt-get install -y php5-fpm
sudo apt-get install -y php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcached php5-ming php5-ps php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-xcache snmp

# install mysql-server (without prompt)
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root' && 
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root' && 
sudo apt-get -y install mysql-server

# install mysql-client
sudo apt-get install -y mysql-client

# install git
sudo apt-get install -y git

# install composer
curl -Ss https://getcomposer.org/installer | php

# bootstrap the public root
if [ ! -d ${document_root} ];  then
	# create public root
	mkdir -p ${document_root}
	# place php info
	echo "<?php phpinfo(); ?>" >> ${document_root}/index.php
fi

# restart server
sudo service nginx restart
