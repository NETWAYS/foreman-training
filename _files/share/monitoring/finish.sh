#!/bin/bash
wget -O - https://packages.netways.de/netways-repo.asc | sudo apt-key add -
echo "deb https://packages.netways.de/extras/ubuntu jammy main" | sudo tee /etc/apt/sources.list.d/netways-extras-release.list
wget -O - https://apt.puppetlabs.com/DEB-GPG-KEY-puppet-20250406 | sudo apt-key add -
echo "deb http://apt.puppetlabs.com jammy puppet7" | sudo tee /etc/apt/sources.list.d/puppet7.list
apt update
apt install -y icinga-installer

echo '10.0.0.1 host.localdomain
10.0.0.2 foreman.localdomain
10.0.0.3 monitoring.localdomain' >> /etc/hosts

icinga-installer -S server-db-mysql --initial-admin-username icinga --initial-admin-password icinga

usermod -a -G nagios training

sed -i "s@RewriteBase /icingaweb2/@RewriteBase /icingaweb2/\n\tRewriteCond %{REMOTE_ADDR} ^10\.0\.0\.2\n\tRewriteRule ^(.*)$ - [E=REMOTE_USER:foreman]@" /etc/apache2/conf.d/icingaweb2.conf
systemctl restart apache2

echo 'object ApiUser "foreman" {
  password = "foreman"
  permissions = [ "*" ]
}' >> /etc/icinga2/zones.d/main/api-users.conf
systemctl restart icinga2

echo '[External]
backend = "external"' >> /etc/icingaweb2/authentication.ini
echo '[Foreman]
users = "foreman"
permissions = "module/director, director/api, director/*"' >> /etc/icingaweb2/roles.ini

icingacli director host create foreman_host --object_type template --check_command hostalive
icingacli director service create ssh-linux --object_type template --check_command ssh
icingacli director service create ssh --object_type apply --imports ssh-linux --assign_filter "host.vars.osfamily=%22Redhat%22 || host.vars.osfamily=%22Debian%22"
icingacli director config deploy
