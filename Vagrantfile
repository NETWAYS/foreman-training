# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.define "mirror" do |mirror|
    mirror.vm.box = "centos/7"
    mirror.vm.hostname = "mirror.localdomain"
    mirror.vm.synced_folder ".", "/vagrant", type: "rsync"

    mirror.vm.provision "shell", inline: <<-SHELL
      sleep 10
      sudo yum -y install rsync httpd wget
      sudo systemctl enable httpd.service
      sudo systemctl start httpd.service
      # CentOS 8
      sudo mkdir -p /var/www/html/centos/8.2.2004/{BaseOS,AppStream}/x86_64
      sudo ln -s /var/www/html/centos/8.2.2004 /var/www/html/centos/8
      sudo rsync  -avSHP --delete --exclude "local*" --exclude "isos" mirror.eu.oneandone.net::centos/8.2.2004/BaseOS/x86_64/ /var/www/html/centos/8.2.2004/BaseOS/x86_64/
      sudo rsync  -avSHP --delete --exclude "local*" --exclude "isos" mirror.eu.oneandone.net::centos/8.2.2004/AppStream/x86_64/ /var/www/html/centos/8.2.2004/AppStream/x86_64/
      sudo mkdir -p /var/www/html/epel/8/{Everything,Modular}/x86_64/
      sudo rsync -vaH --exclude="debug*" --numeric-ids --delete --delete-after --delay-updates rsync://rsync.hrz.tu-chemnitz.de/fedora-epel/8/Everything/x86_64/ /var/www/html/epel/8/Everything/x86_64/
      sudo rsync -vaH --exclude="debug*" --numeric-ids --delete --delete-after --delay-updates rsync://rsync.hrz.tu-chemnitz.de/fedora-epel/8/Modular/x86_64/ /var/www/html/epel/8/Modular/x86_64/
      sudo mkdir -p /var/www/html/puppet6/el/8/x86_64/
      sudo rsync -av --copy-links --del --exclude "pdk*" --exclude "puppet-bolt*" --exclude "puppetdb*" --exclude="puppetserver*" rsync://rsync.puppet.com/packages/yum/puppet6/el/8/x86_64/ /var/www/html/puppet6/el/8/x86_64/
      sudo mkdir -p /var/www/html/foreman/releases/latest/el8/x86_64/
      sudo rsync -av --copy-links --del rsync://rsync.theforeman.org/yum/releases/latest/el8/x86_64/ /var/www/html/foreman/releases/latest/el8/x86_64/
      sudo mkdir -p /var/www/html/foreman/plugins/latest/el8/x86_64/
      sudo rsync -av --copy-links --del rsync://rsync.theforeman.org/yum/plugins/latest/el8/x86_64/ /var/www/html/foreman/plugins/latest/el8/x86_64/
      sudo mkdir -p /var/www/html/foreman/client/latest/el8/x86_64/
      sudo rsync -av --copy-links --del rsync://rsync.theforeman.org/yum/client/latest/el8/x86_64/ /var/www/html/foreman/client/latest/el8/x86_64/
      sudo mkdir -p /var/www/html/foreman/discovery
      sudo rm /var/www/html/foreman/discovery/fdi-image-latest.tar
      sudo wget -P /var/www/html/foreman/discovery http://downloads.theforeman.org/discovery/releases/latest/fdi-image-latest.tar
    SHELL
  end

  config.vm.define "foreman" do |foreman|
    foreman.vm.box = "centos/8"
    foreman.vm.hostname = "foreman.localdomain"
    foreman.vm.synced_folder ".", "/vagrant", type: "rsync"

    foreman.vm.provision "shell", path: "_files/share/foreman/finish.sh"
  end

  config.vm.define "monitoring" do |foreman|
    foreman.vm.box = "centos/8"
    foreman.vm.hostname = "monitoring.localdomain"
    foreman.vm.synced_folder ".", "/vagrant", type: "rsync"

    foreman.vm.provision "file", source: "_files/share/monitoring/monitoring.localdomain.pp", destination: "~/"
    foreman.vm.provision "file", source: "_files/share/monitoring/icingaweb2.conf", destination: "~/"
    foreman.vm.provision "shell", path: "_files/share/monitoring/finish.sh"
  end
end
