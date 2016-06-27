# Setting up a LEMP stack on a virtual machine

This is how I set up a LEMP-Stack on a virtual machine for sandbox projects. The Vagrantfile comes with a bootstrap.sh setting up everything you need on a virtual machine. Feel free to customize the bootstrapping to fit your needs.

# Setup

1. create a entry in your hosts file

> 111.111.11.11 dev.local

2. run `vagrant up` to build up a LEMP stack 

The vagrant box is now setting up the environment with the ip *111.111.11.11*
If not found the bootstrap.sh creates the public root for your application.

> app/public

and places an index.php outputting `phpinfo()` to demonstrate php is up and running.

## Change the document root

You can simply assign an other document root by changing the corresponding line in ./box-settings/bootstrap.sh:
document_root="/vagrant/app/public"

# Connect with HeidiSQL via SSH-Tunnel to the running vagrant box

Settings
---------
Type: MySQL (SSH tunnel)
Hostname/IP: localhost
User: root
Pass: root
Port: 3306

SSH Tunnel
----------
plink.exe :selected
SSH Host: 111.111.11.11
Port: 0
User: vagrant
Pass: vagrant