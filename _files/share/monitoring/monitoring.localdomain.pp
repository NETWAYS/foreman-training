# yum install epel-release -y
# yum install http://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm -y
# yum install puppet-agent -y
# puppet module install puppetlabs-apache
# puppet module install puppetlabs-mysql
# puppet module install icinga-icinga2
# puppet module install icinga-icingaweb2

Exec {
  path    => '/usr/bin:/usr/sbin',
}

# Yum update

exec { 'yumupdate':
  command => 'yum -y -q update', 
  unless  => 'yum check-update -q',
  path    => '/usr/bin:/usr/sbin',
}

# Install basic packages

package { [ 'vim-enhanced', 'yum-utils' ]:
  ensure  => 'installed',
  require => Exec['yumupdate']
}

# Remove old kernels

exec { 'package-cleanup --oldkernels --count=1 -q':
  unless => 'package-cleanup --oldkernels --count=1 -q',
  path   => '/usr/bin:/usr/sbin',
}

# Set hostname

exec { 'hostnamectl set-hostname monitoring.localdomain':
  unless => 'hostname | grep monitoring.localdomain',
  path   => '/usr/bin:/usr/sbin',
}

host { 'foreman.localdomain':
  ip           => '10.0.0.2',
  host_aliases => 'foreman'
}

host { 'monitoring.localdomain':
  ip           => '10.0.0.3',
  host_aliases => 'monitoring'
}

# Manage user "root"

user { 'root':
  ensure   => 'present',
  password => '$6$1t.s4Ppq$om1Rvc9FGMnPCkJhSD7JAnWd30DaxhYsGTQJMq8qAh6AotB8JIaqRIJFCCvskYruEN3Z/aaBMvI42B5B/22sy.',
}

# Set SELinux to permissive

file_line { '/etc/sysconfig/selinux':
  ensure => 'present',
  path   => '/etc/sysconfig/selinux',
  match  => "^SELINUX=.*$",
  line   => 'SELINUX=permissive',
}

exec { 'setenforce 0':
  unless => 'getenforce | grep Permissive',
  path   => '/usr/bin:/usr/sbin',
}

# Stop firewalld

service { 'firewalld':
  ensure => 'stopped',
  enable => false,
}

# MariaDB

include ::mysql::server

mysql::db { 'icinga':
  user     => 'icinga',
  password => 'icinga',
  host     => 'localhost',
  grant    => ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'DROP', 'CREATE VIEW', 'CREATE', 'INDEX', 'EXECUTE', 'ALTER'],
}

mysql::db { 'icingaweb2':
  user     => 'icingaweb2',
  password => 'icingaweb2',
  host     => 'localhost',
  grant    => ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'DROP', 'CREATE VIEW', 'CREATE', 'INDEX', 'EXECUTE', 'ALTER', 'REFERENCES'],
}

mysql::db { 'director':
  user     => 'director',
  password => 'director',
  host     => 'localhost',
  grant    => ['ALL'],
}

# Plugins

package { [ 'nagios-plugins-all' ]:
  ensure => 'installed',
  require => Exec['yumupdate'],
}

# Icinga 2

class { '::icinga2':
  manage_repo => true,
  confd       => false,
  features    => ['checker', 'mainlog', 'command'],
}

class { '::icinga2::feature::idomysql':
  user          => 'icinga',
  password      => 'icinga',
  database      => 'icinga',
  import_schema => true,
  require       => Mysql::Db['icinga'],
}

class { '::icinga2::pki::ca':
}

class { '::icinga2::feature::api':
  accept_commands => true,
  accept_config   => true,
  endpoints       => {
    'monitoring.localdomain'    => {},
  },
  zones           => {
    'master' => {
      'endpoints' => ['monitoring.localdomain'],
    },
  },
  pki => 'none',
}

icinga2::object::zone { 'director-global':
  global => true,
}

file { '/etc/icinga2/zones.d/master':
  ensure => directory,
}

icinga2::object::apiuser { 'director':
  password => 'director',
  permissions => [ '*' ],
  target => '/etc/icinga2/zones.d/master/apiusers.conf',
}

icinga2::object::apiuser { 'foreman':
  password => 'foreman',
  permissions => [ '*' ],
  target => '/etc/icinga2/zones.d/master/apiusers.conf',
}

# Apache

class { 'apache':
  mpm_module => 'prefork',
}

class { 'apache::mod::php': }

file {'/etc/httpd/conf.d/icingaweb2.conf':
  source  => '/root/icingaweb2.conf',
  require => Class['apache'],
  notify  => Service['httpd'],
}

augeas { 'php.ini':
  context => '/files/etc/php.ini/PHP',
  changes => ['set date.timezone Europe/Berlin',],
  require => Class['apache'],
}

# Icinga Web 2 (Login: icinga/icinga)

package {'php-mysql':
  ensure => installed,
}

class {'icingaweb2':
  import_schema => true,
  db_type       => 'mysql',
  db_host       => 'localhost',
  db_username   => 'icingaweb2',
  db_password   => 'icingaweb2',
  require       => Mysql::Db['icingaweb2'],
}

icingaweb2::config::authmethod {'External':
  backend => 'external',
}

icingaweb2::config::role {'Foreman':
  users => 'foreman',
  permissions => 'module/director, director/api, director/*'
}

class {'icingaweb2::module::monitoring':
  ido_host        => 'localhost',
  ido_db_name     => 'icinga',
  ido_db_username => 'icinga',
  ido_db_password => 'icinga',
  commandtransports => {
    icinga2 => {
      transport => 'local'
    }
  },
}

package { 'git':
  ensure => installed,
}

class {'icingaweb2::module::director':
  db_host       => 'localhost',
  db_name       => 'director',
  db_username   => 'director',
  db_password   => 'director',
  import_schema => true,
  kickstart     => true,
  endpoint      => 'monitoring.localdomain',
  api_username  => 'director',
  api_password  => 'director',
  require       => Mysql::Db['director']
}

exec { 'Create host template foreman_host':
  command => 'icingacli director host create foreman_host --object_type template --check_command hostalive',
  unless  => 'icingacli director host exists foreman_host',
}

exec { 'Create service template ssh':
  command => 'icingacli director service create ssh --object_type template --check_command ssh',
  unless  => 'icingacli director service exists ssh',
}

exec { 'Create service apply ssh':
  command => 'icingacli director service create ssh --object_type apply --imports ssh --assign_filter "host.vars.osfamily=%22Redhat%22 || host.vars.osfamily=%22Debian%22"',
}

exec { 'Deploy configuration':
  command => 'icingacli director config deploy',
}
