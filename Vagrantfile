# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  #config.vm.box = "scalefactory/centos6"
  #config.vm.network "private_network", ip: "192.168.1.2"
  #config.vm.network "public_network", ip: "192.168.0.5"

  config.vm.box = "centos/7"
  config.vm.network "public_network"
  #config.vm.network "forwarded_port", guest: 80, host: 8888, host_ip: "0.0.0.0"
  config.vm.synced_folder "/vagrant/www", "./www",owner:"root",group:"root", :mount_options => ["dmode=755","fmode=644"]
  
  config.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
      vb.name = "trensy"
  end

  config.vm.provision "shell", inline: <<-SHELL
    sudo su -
    sed -i -e 's/\r$//' /vagrant/opt/install.sh
    chmod 0777 /vagrant/opt/install.sh
    /vagrant/opt/install.sh
  SHELL

end
