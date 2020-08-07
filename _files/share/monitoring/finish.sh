#!/bin/bash
yum install epel-release -y
yum install http://yum.puppetlabs.com/puppet6/puppet6-release-el-8.noarch.rpm -y
yum install puppet-agent -y
/opt/puppetlabs/bin/puppet module install puppetlabs-apache
/opt/puppetlabs/bin/puppet module install puppetlabs-mysql
/opt/puppetlabs/bin/puppet module install icinga-icinga2
/opt/puppetlabs/bin/puppet module install icinga-icingaweb2
/opt/puppetlabs/bin/puppet apply -v monitoring.localdomain.pp
