#!/usr/bin/env bash

PASSWORD='password'

sudo apt-get update
sudo apt-get -y upgrade

sudo apt-get install -y apache2
sudo ufw allow in "Apache Full"
sudo apt-get install -y php

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
sudo apt-get install -y mysql-server

# Setup Host file
VHOST=$(cat <<EOF
<VirtualHost *:80>
    DocumentRoot "/var/www/html"
    <Directory "/var/www/html/">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf

# Install PHP extensions
sudo apt-get install -y libapache2-mod-php php-mcrypt php-mysql

# Update dir.conf to have index.php first
AMODS=$(car <<EOF
<IfModule mod_dir.c>
    DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm
</IfModule>
EOF
)
echo "${AMODS}" > /etc/apache2/mods-enabled/dir.conf

# Enable mod_rewrite
sudo a2enmod rewrite

# Restart Apache because of enabling rewrite
sudo service apache2 restart

# Removed Apaches Default File
sudo rm "/var/www/html/index.html"

# Final Feedback
echo "Finished Installing and Setting Up Apache, MySQL and PHP"