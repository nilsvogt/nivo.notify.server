#! /usr/bin/env bash

# assign the root directory of your server
#
document_root="/vagrant/app/public"

# add repository ppa:ondrej/php in order to install the php7 stack
#
sudo apt-get install -y language-pack-en-base &&
sudo LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php &&
sudo add-apt-repository ppa:ondrej/php &&

# Once the PPA is installed, update the local package cache to include its contents:
#
apt-get update

# install server (nginx)
#
sudo apt-get install -y nginx

# set nginx config
#
sudo rm /etc/nginx/sites-available/default
sudo cp /vagrant/box-settings/nginx.default /etc/nginx/sites-available/default

# link document root
#
if ! [ -L /usr/share/nginx/html ]; then
  rm -rf /usr/share/nginx/html
  ln -fs ${document_root} /usr/share/nginx/html
fi

# install php 7 stack
#
sudo apt-get install -y php7.0-fpm php7.0 php7.0-mysql php7.0-curl php7.0-gd php7.0-intl php-pear php7.0-imap php7.0-mcrypt php7.0-sqlite3 snmp

# install xdebug
#
sudo apt-get install -y php7.0-dev &&
sudo pecl install xdebug &&
sudo bash -c "cat /vagrant/box-settings/xdebug-php.ini >> /etc/php/7.0/fpm/php.ini"

# install mysql-server (without prompt)
#
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root' &&
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root' &&
sudo apt-get -y install mysql-server

# install mysql-client
#
sudo apt-get install -y mysql-client

# install git
#
sudo apt-get install -y git

# install composer
#
curl -Ss https://getcomposer.org/installer | php &&
mv composer.phar /usr/local/bin/composer

# bootstrap the public root
#
if [ ! -d ${document_root} ];  then
	# create public root
	mkdir -p ${document_root}
	# place php info
	echo "<?php phpinfo(); ?>" >> ${document_root}/index.php
fi

# restart server
#
sudo service php7.0-fpm restart
sudo service nginx restart