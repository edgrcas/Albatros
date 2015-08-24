FROM ubuntu:15.04
MAINTAINER Edgar Castanheda <edgar.castaneda@clicksandbricks.pe>

#UPDATE
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
  apt-get upgrade -y

# INSTALL SUPERVISOR
RUN apt-get install -y supervisor && \
    mkdir -p /var/log/supervisor && \
    supervisord --version
ADD configs/supervisor/supervisor.conf /etc/supervisor/conf.d/supervisor.conf

# INSTALL Apache2
ADD configs/apache2/apache2-service.sh /apache2-service.sh
RUN apt-get install -y apache2 && \
  chmod +x /*.sh && \
    a2enmod rewrite
ADD configs/apache2/apache_default /etc/apache2/sites-available/000-default.conf
ADD configs/apache2/supervisor.conf /etc/supervisor/conf.d/apache2.conf

#INSTALL GIT
RUN apt-get install -y software-properties-common wget \
    git mercurial subversion && \
    git --version && \
    hg --version && \
    svn --version

#INSTALL PHP

RUN apt-get install -y php-pear php5-cgi php5-json php5-cli php5-curl curl \
    php5-mcrypt php5-xdebug mcrypt libmcrypt-dev php5-mysql php5-gd php5-sqlite \
    sqlite && \
    php5enmod mcrypt pdo pdo_sqlite sqlite3 && \
    php --version
ADD configs/php/php-cli.ini /etc/php5/cli/conf.d/dockie-dockie.ini
RUN apt-get install -y libapache2-mod-php5 php5 php5-json php5-cli php5-curl curl php5-mcrypt php5-xdebug mcrypt libmcrypt-dev
ADD configs/php/php.ini /etc/php5/apache2/conf.d/30-docker.ini

# INSTALL MySQL
ADD configs/mysql/mysql-setup.sh /mysql-setup.sh
ADD configs/mysql/my.cnf /etc/mysql/conf.d/my.cnf
ADD configs/mysql/supervisor.conf /etc/supervisor/conf.d/mysql.conf
RUN apt-get install -y mysql-server mysql-client php5-mysql && chmod +x /*.sh && bash /mysql-setup.sh

#INSTALL COMPOSER
ENV COMPOSER_HOME /root/.composer
ENV PATH $COMPOSER_HOME/vendor/bin:$PATH
RUN curl -sS https://getcomposer.org/installer | php -- --filename=composer \
    --install-dir=/usr/bin --version=1.0.0-alpha10
RUN composer --version

#INSTALL PYTHON
RUN apt-get install -y python python3 python-pil pylint && \
    python --version && \
    python3 --version

#INSTALL NODE
RUN apt-get install -y build-essential && \
    curl -sL https://deb.nodesource.com/setup_0.12 | sh -
RUN apt-get install -y nodejs && \
    nodejs --version && \
    npm --version && \
    npm install -g coffee-script bower grunt-cli gulp component yo eslint

#INSTALL ADDONS NODE
COPY configs/node/install_phantomjs.sh /install_phantomjs.sh
RUN chmod +x /install_phantomjs.sh
RUN bash /install_phantomjs.sh

#UTILS
RUN apt-get install -y mysql-client unzip

# INSTALL PHPMyAdmin
RUN (echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections)
RUN (echo 'phpmyadmin phpmyadmin/app-password password root' | debconf-set-selections)
RUN (echo 'phpmyadmin phpmyadmin/app-password-confirm password root' | debconf-set-selections)
RUN (echo 'phpmyadmin phpmyadmin/mysql/admin-pass password root' | debconf-set-selections)
RUN (echo 'phpmyadmin phpmyadmin/mysql/app-pass password root' | debconf-set-selections)
RUN (echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections)
RUN apt-get install phpmyadmin -y
ADD configs/phpmyadmin/config.inc.php /etc/phpmyadmin/conf.d/config.inc.php
RUN chmod 755 /etc/phpmyadmin/conf.d/config.inc.php
ADD configs/phpmyadmin/phpmyadmin-setup.sh /phpmyadmin-setup.sh
RUN chmod +x /phpmyadmin-setup.sh
RUN /phpmyadmin-setup.sh
RUN apt-get upgrade && apt-get update

#INSTALL MONGO DRIVER 3
COPY configs/mongo/mongo_driver.sh /mongo_driver.sh
RUN chmod +x /mongo_driver.sh
RUN bash /mongo_driver.sh

#INSTALL MONITOR FILES
RUN apt-get install inotify-tools -y
COPY configs/monitor.sh /monitor.sh
RUN chmod +x /monitor.sh
RUN mv monitor.sh /usr/local/bin/monitor

#SET ServerName
RUN echo "ServerName 'YourDomain.com'" >> /etc/apache2/apache2.conf

#INSTALL APACHE AUTO-ALIAS
COPY configs/apache2/auto_alias.sh /auto_alias.sh
COPY configs/apache2/domains.sh /domains.sh
COPY configs/apache2/albatros.local.conf /etc/apache2/sites-available/albatros.local.conf
RUN chmod +x /domains.sh /auto_alias.sh
RUN bash /auto_alias.sh

#CLEAN
RUN apt-get clean && apt-get autoremove

#SET TERMINAL
ENV TERM dumb
CMD ["supervisord"]
VOLUME /var/www/html
EXPOSE 22 80 3306
