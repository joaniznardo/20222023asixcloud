#!/bin/bash
sed  -i -e '/{restart}/ s/i/l/' -e '/{restart}/ s/^#//' /etc/needrestart/needrestart.conf

DEBIAN_FRONTEND="noninteractive"

apt -qq update
apt -qq install -y mysql-server

WORDPRESS_DOMAIN=asix-test-wp-02.duckdns.org

# el nom de la base de dades no pot tindre "-" (crec)
WORDPRESS_DB=wp_demo_db7
WORDPRESS_USER=wp_demo_user2
#WORDPRESS_HOST='10.0.1.232'
WORDPRESS_HOST='XXXX'
WORDPRESS_USER_PASS=P-3ssw8rd1nsegvr5




tee configura-db.sql << EOF
CREATE DATABASE $WORDPRESS_DB;
CREATE USER $WORDPRESS_USER@$WORDPRESS_HOST
IDENTIFIED BY '$WORDPRESS_USER_PASS';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER 
ON $WORDPRESS_DB.* 
TO $WORDPRESS_USER@$WORDPRESS_HOST;
FLUSH PRIVILEGES;
EOF

# cat configura-db.sql | sudo mysql --defaults-extra-file=/etc/mysql/debian.cnf
cat configura-db.sql | mysql  -u root
sudo sed -i '/bind-address/s|127.0.0.1|0.0.0.0|' /etc/mysql/mysql.conf.d/mysqld.cnf 
sudo systemctl restart mysql.service
