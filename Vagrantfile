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
  #config.vm.synced_folder "/vagrant/nginx_conf_tengine", "/server/software/nginx/conf",owner:"root",group:"root", :mount_options => ["dmode=755","fmode=644"]
  #config.vm.network :public_network, auto_config: true, ip: "192.168.5.2", bridge:"ens1f0", bootproto: "static", gateway: "192.168.5.1"
  
  config.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 2
      vb.name = "trensy"
  end

  config.vm.provision "shell", inline: <<-SHELL
    sudo su -
    yum -y update
    yum -y install gcc-c++
    yum -y install autoconf
    yum -y install lrzsz
    yum -y install pcre pcre-devel
    yum -y install openssl
    yum -y install openssl-devel

    tar xf /vagrant/opt/nginx-1.10.2.tar.gz -C /usr/src/ && cd /usr/src/nginx-1.10.2/
    ./configure --prefix=/srv/nginx --with-http_ssl_module --with-http_gzip_static_module --with-http_stub_status_module --with-pcre
    make -j4 && make install

    cp /vagrant/opt/nginx  /etc/init.d/nginx
    chmod a+x /etc/init.d/nginx
    \cp -rf /vagrant/opt/nginx.conf /srv/nginx/conf/

    yum -y install libxml2
    yum -y install libxml2-devel
    yum -y install openssl
    yum -y install openssl-devel
    yum -y install curl
    yum -y install curl-devel
    yum -y install libjpeg
    yum -y install libjpeg-devel
    yum -y install libpng
    yum -y install libpng-devel
    yum -y install freetype
    yum -y install freetype-devel
    yum -y install pcre
    yum -y install pcre-devel
    yum -y install libxslt
    yum -y install libxslt-devel
    yum -y install bzip2
    yum -y install bzip2-devel

    tar xf /vagrant/opt/php-7.1.0.tar.gz -C /usr/src/ && cd /usr/src/php-7.1.0/
    ./configure --prefix=/srv/php --with-curl --with-freetype-dir --with-gd --with-gettext --with-iconv-dir --with-kerberos --with-libdir=lib64 --with-libxml-dir --with-mysqli --with-openssl --with-pcre-regex --with-pdo-mysql --with-pdo-sqlite --with-pear --with-png-dir --with-jpeg-dir --with-xmlrpc --with-xsl --with-zlib --with-bz2 --with-mhash --enable-fpm --enable-bcmath --enable-libxml --enable-inline-optimization --enable-gd-native-ttf --enable-mbregex --enable-mbstring --enable-opcache --enable-pcntl --enable-shmop --enable-soap --enable-sockets --enable-sysvsem --enable-sysvshm --enable-xml --enable-zip
    make -j4 && make install

    \cp -rf /vagrant/opt/php.ini /srv/php/lib/php.ini
    \cp -rf /vagrant/opt/php-fpm.conf /srv/php/etc/php-fpm.conf
    \cp -rf /vagrant/opt/www.conf /srv/php/etc/php-fpm.d/www.conf
    mkdir -p /srv/php/var/session
    mkdir -p /srv/php/log/
    echo 'export PATH="/srv/php/bin:$PATH"'>>/etc/profile
    source /etc/profile

    curl -sS https://getcomposer.org/installer | php
    mv composer.phar /usr/local/bin/composer
    chmod a+x /usr/local/bin/composer

    \cp -rf /usr/src/php-7.1.0/sapi/fpm/init.d.php-fpm  /etc/init.d/php-fpm
    chmod a+x /etc/init.d/php-fpm

    tar xf /vagrant/opt/swoole-src-4.2.1.tar.gz -C /usr/src/ && cd /usr/src/swoole-src-4.2.1/
    /srv/php/bin/phpize
    ./configure --with-php-config=/srv/php/bin/php-config --disable-openssl --disable-http2 --disable-async-redis --disable-sockets --disable-mysqlnd
    make -j4 && make install
    echo 'extension="swoole.so"' >>/srv/php/lib/php.ini

    yum install -y http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
    yum --enablerepo=remi -y install redis

    systemctl start redis
    systemctl start php-fpm 
    systemctl start nginx

  SHELL

end
