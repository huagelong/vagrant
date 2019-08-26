#!/bin/bash
yum -y update
yum -y install gcc-c++
yum -y install autoconf
yum -y install lrzsz
yum -y install pcre pcre-devel
yum -y install openssl
yum -y install openssl-devel
yum -y install vim
yum -y install kernel-devel-3.10.0-862.14.4.el7.x86_64
tar xf /opt/vagrant/opt/nginx-1.10.2.tar.gz -C /usr/src/ && cd /usr/src/nginx-1.10.2/
./configure --prefix=/opt/nginx --with-http_ssl_module --with-http_gzip_static_module --with-http_stub_status_module --with-pcre
make -j4 && make install
\cp -rf /opt/vagrant/opt/nginx /etc/init.d/nginx
chmod a+x /etc/init.d/nginx
\cp -rf /opt/vagrant/opt/nginx.conf /opt/nginx/conf/
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
yum -y install telnet
yum -y install lsof
yum -y install htop
tar xf /opt/vagrant/opt/php-7.2.21.tar.gz -C /usr/src/ && cd /usr/src/php-7.2.21/
./configure --prefix=/opt/php --with-curl --with-freetype-dir --with-gd --with-gettext --with-iconv-dir --with-kerberos --with-libdir=lib64 --with-libxml-dir --with-mysqli --with-openssl --with-pcre-regex --with-pdo-mysql --with-pdo-sqlite --with-pear --with-png-dir --with-jpeg-dir --with-xmlrpc --with-xsl --with-zlib --with-bz2 --with-mhash --enable-fpm --enable-bcmath --enable-libxml --enable-inline-optimization --enable-gd-native-ttf --enable-mbregex --enable-mbstring --enable-opcache --enable-pcntl --enable-shmop --enable-soap --enable-sockets --enable-sysvsem --enable-sysvshm --enable-xml --enable-zip
make -j4 && make install
\cp -rf /opt/vagrant/opt/php.ini /opt/php/lib/php.ini
\cp -rf /opt/vagrant/opt/php-fpm.conf /opt/php/etc/php-fpm.conf
\cp -rf /opt/vagrant/opt/www.conf /opt/php/etc/php-fpm.d/www.conf
mkdir -p /opt/php/var/session
mkdir -p /opt/php/log/
ln -s /opt/php/bin/php /usr/bin/php
echo 'export PATH="/opt/php/bin:$PATH"'>>/etc/profile
source /etc/profile
\cp -rf /opt/vagrant/opt/composer /usr/local/bin/composer
chmod a+x /usr/local/bin/composer
\cp -rf /usr/src/php-7.2.21/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod a+x /etc/init.d/php-fpm
tar xf /opt/vagrant/opt/swoole-src-4.4.4.tar.gz -C /usr/src/ && cd /usr/src/swoole-src-4.4.4/
/opt/php/bin/phpize
./configure --with-php-config=/opt/php/bin/php-config --disable-openssl --disable-http2 --enable-async-redis --disable-sockets --enable-mysqlnd
make -j4 && make install
echo 'extension="swoole.so"' >>/opt/php/lib/php.ini
tar xf /opt/vagrant/opt/phpredis-5.0.2.tar.gz -C /usr/src/ && cd /usr/src/phpredis-5.0.2/
/opt/php/bin/phpize
./configure --with-php-config=/opt/php/bin/php-config
make -j4 && make install
echo 'extension="redis.so"' >>/opt/php/lib/php.ini
cd /vagrant/opt
tar xf /opt/vagrant/opt/mysql.tar.gz -C /usr/src/ && cd /usr/src/mysql-386776d/
phpize
./configure
make -j4 && make install
echo 'extension="mysql.so"' >>/opt/php/lib/php.ini
groupadd www-data
useradd -g www-data www-data
service php-fpm start
service nginx start