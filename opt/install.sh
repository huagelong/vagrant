#!/usr/bin/bash
yum -y update
yum -y install gcc-c++
yum -y install autoconf
yum -y install lrzsz
yum -y install pcre pcre-devel
yum -y install openssl
yum -y install openssl-devel
yum -y install vim
yum -y install kernel-devel-3.10.0-862.14.4.el7.x86_64
tar xf /vagrant/opt/nginx-1.10.2.tar.gz -C /usr/src/ && cd /usr/src/nginx-1.10.2/
./configure --prefix=/srv/nginx --with-http_ssl_module --with-http_gzip_static_module --with-http_stub_status_module --with-pcre
make -j4 && make install
\cp -rf /vagrant/opt/nginx /etc/init.d/nginx
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
\cp -rf /vagrant/opt/composer /usr/local/bin/composer
chmod a+x /usr/local/bin/composer
\cp -rf /usr/src/php-7.1.0/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod a+x /etc/init.d/php-fpm
tar xf /vagrant/opt/swoole-src-4.2.1.tar.gz -C /usr/src/ && cd /usr/src/swoole-src-4.2.1/
/srv/php/bin/phpize
./configure --with-php-config=/srv/php/bin/php-config --disable-openssl --disable-http2 --disable-async-redis --disable-sockets --disable-mysqlnd
make -j4 && make install
echo 'extension="swoole.so"' >>/srv/php/lib/php.ini
cd /vagrant/opt
tar xf /vagrant/opt/mysql.tar.gz -C /usr/src/ && cd /usr/src/mysql-386776d/
phpize
./configure
make -j4 && make install
echo 'extension="mysql.so"' >>/srv/php/lib/php.ini
yum install -y http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
yum --enablerepo=remi -y install redis
cd /opt/VBoxGuestAdditions-*/init
./vboxadd setup
mount -t vboxsf -o uid=0,gid=0 code /code
service redis start
service php-fpm start
service nginx start