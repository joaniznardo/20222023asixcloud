#!/bin/bash
sed  -i -e '/{restart}/ s/i/l/' -e '/{restart}/ s/^#//' /etc/needrestart/needrestart.conf

EMAILCERTBOT=changeme@sis.plau 
WORDPRESS_DOMAIN=asix-test-wp-04.duckdns.org
# el nom de la base de dades no pot tindre "-" (crec)
WORDPRESS_DB=wp_demo_db7
WORDPRESS_USER=wp_demo_user2
#WORDPRESS_HOST='10.0.2.66'
WORDPRESS_HOST='YYYY'
WORDPRESS_USER_PASS=P-3ssw8rd1nsegvr5

DEBIAN_FRONTEND="noninteractive"

apt -qq update
apt -qq install -y apache2 \
                 mysql-client \
                 ghostscript \
                 libapache2-mod-php \
                 php \
                 php-bcmath \
                 php-curl \
                 php-imagick \
                 php-intl \
                 php-json \
                 php-mbstring \
                 php-mysql \
                 php-xml \
                 php-zip \
                 pwgen
                 



mkdir -p /srv/www

echo $WORDPRESS_DOMAIN | tee -a /srv/wp-init
echo $WORDPRESS_USER_PASS | tee -a /srv/wp-init

chown www-data: /srv/www
curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www

tee /etc/apache2/sites-available/wordpress.conf << EOF
<VirtualHost *:80>
    DocumentRoot /srv/www/wordpress
    <Directory /srv/www/wordpress>
        Options FollowSymLinks
        AllowOverride Limit Options FileInfo
        DirectoryIndex index.php
        Require all granted
    </Directory>
    <Directory /srv/www/wordpress/wp-content>
        Options FollowSymLinks
        Require all granted
    </Directory>
</VirtualHost>
EOF

a2ensite wordpress
a2enmod rewrite
a2enmod ssl
a2dissite 000-default
service apache2 reload

sudo -u www-data cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php

sudo -u www-data sed -i 's/database_name_here/'"$WORDPRESS_DB"'/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/username_here/'"$WORDPRESS_USER"'/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/password_here/'"$WORDPRESS_USER_PASS"'/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/localhost/'"$WORDPRESS_HOST"'/' /srv/www/wordpress/wp-config.php


#sudo -u www-data nano /srv/www/wordpress/wp-config.php
sed -i "/'AUTH_KEY'/ s/'put your unique phrase here'/'flipant07'/"  /srv/www/wordpress/wp-config.php
sed -i "/'SECURE_AUTH_KEY'/ s/'put your unique phrase here'/'flipant08'/"  /srv/www/wordpress/wp-config.php
sed -i "/'LOGGED_IN_KEY'/ s/'put your unique phrase here'/'flipant04'/"  /srv/www/wordpress/wp-config.php
sed -i "/'NONCE_KEY'/ s/'put your unique phrase here'/'flipant01'/"  /srv/www/wordpress/wp-config.php
sed -i "/'AUTH_SALT'/ s/'put your unique phrase here'/'flipant06'/"  /srv/www/wordpress/wp-config.php
sed -i "/'SECURE_AUTH_SALT'/ s/'put your unique phrase here'/'flipant05'/"  /srv/www/wordpress/wp-config.php
sed -i "/'LOGGED_IN_SALT'/ s/'put your unique phrase here'/'flipant03'/"  /srv/www/wordpress/wp-config.php
sed -i "/'NONCE_SALT'/ s/'put your unique phrase here'/'flipant02'/"  /srv/www/wordpress/wp-config.php


snap install certbot --classic
#sudo certbot --apache -d asix2a.duckdns.org

### 
### la següent instrucció generarà una nova entrada de manera automàtica a /etc/apache2/sites-available: una oportunitat de millora ;)
###

### 
###
### sudo certbot -n --apache --agree-tos --redirect --hsts --uir --staple-ocsp --email demo@example.com -d $WORDPRESS_DOMAIN
#sudo certbot -n --apache --agree-tos --redirect --hsts --uir --staple-ocsp --email $EMAILCERTBOT -d $WORDPRESS_DOMAIN
sudo certbot -n --apache --agree-tos --redirect --hsts --uir --staple-ocsp --register-unsafely-without-email -d $WORDPRESS_DOMAIN

