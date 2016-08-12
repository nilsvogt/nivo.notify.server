# LEMP stack on a virtual machine using Vagrant

This is how I set up a LEMP-Stack on a virtual machine for sandboxed projects. The Vagrantfile comes with a bootstrap.sh setting up everything you need on a virtual machine. Feel free to customize the bootstrapping to fit your needs.

## The setup installs and configures the tools below on a virtual ubuntu machine

- curl, zip, unzip
- nginx
- php7
- mysql
- xdebug
- phpunit
- git
- composer

After successfully setup of the environment, the `bootstrap.sql` will be passed to mysql so thats a handy place to put a database dump in. Anyway, since this is optional you simply can remove this file if you do not need it.

# Setup

customize the bootstrap configuration in `box-settings/config.sh` (optional)

assign the root directory of your server:
> document_root="/vagrant/app/public"  
set the database user:  
> db_username="root"  
set the database pass:  
> db_password="root"

create an entry in your hosts file (optional)

> 111.111.11.11	dev.local

run `vagrant up`

The vagrant box is now setting up the environment with the ip *111.111.11.11*
If not found the bootstrap.sh creates the public root for your application:

> app/public

and places an index.php outputting `phpinfo()` to demonstrate php is up and running.

## Change the document root

You can simply assign another document root by changing the corresponding line in ./box-settings/bootstrap.sh:

> document_root="/vagrant/app/public"

# Connect with HeidiSQL

Settings
---------
- Type: `MySQL (SSH tunnel)`
- Hostname/IP: `localhost`
- User: `root`
- Pass: `root`
- Port: `3306`

SSH Tunnel
----------
- plink.exe :selected
- SSH Host: `111.111.11.11`
- Port: `0`
- User: `vagrant`
- Pass: `vagrant`

# Debug with PHPStorm and XDebug

- "select run/Debug configuration"
- "edit configuration"
- (+) "PHP Remote Debgug"
- "IDE-KEY": `PHPSTORM`
- Server Configuration:
  - `127.0.0.1:8080`
  - XDebug
  - map "Project files" root to "/vagrant"

Start debugging session in PHPStorm and your Browser
