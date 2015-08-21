FROM dockie/lamp
MAINTAINER Edgar Castanheda <edgar.castaneda@clicksandbricks.pe>

# INSTALL MONGO
RUN groupadd -r mongodb && useradd -r -g mongodb mongodb
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates curl \
        numactl \
    && rm -rf /var/lib/apt/lists/*

# grab gosu for easy step-down from root
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu
# gpg: key 7F0CEB10: public key "Richard Kreuter <richard@10gen.com>" imported
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 492EAFE8CD016A07919F1D2B9ECBEC467F0CEB10

ENV MONGO_MAJOR 3.0
ENV MONGO_VERSION 3.0.4
RUN echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/$MONGO_MAJOR main" > /etc/apt/sources.list.d/mongodb-org.list
RUN set -x \
    && apt-get update \
    && apt-get install -y \
    mongodb-org=$MONGO_VERSION \
    mongodb-org-server=$MONGO_VERSION \
    mongodb-org-shell=$MONGO_VERSION \
    mongodb-org-mongos=$MONGO_VERSION \
    mongodb-org-tools=$MONGO_VERSION \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/lib/mongodb \
    && mv /etc/mongod.conf /etc/mongod.conf.orig

RUN mkdir -p /data/db && chown -R mongodb:mongodb /data/db
VOLUME /data/db

COPY configs/mongo/mongo_entrypoint.sh /mongo_entrypoint.sh
RUN apt-get upgrade && apt-get update

#UPDATE COMPOSER
RUN composer self-update

#INSTALL MONGO DRIVER 3
COPY configs/mongo/mongo_driver.sh /mongo_driver.sh
RUN chmod +x /mongo_driver.sh
RUN bash /mongo_driver.sh

#INSTALL MONITOR FILES
RUN apt-get install inotify-tools -y
COPY configs/monitor.sh /monitor.sh
RUN chmod +x /monitor.sh

#INSTALL APACHE AUTO-ALIAS
COPY configs/apache2/auto_alias.sh /auto_alias.sh
COPY configs/apache2/domains.sh /domains.sh
COPY configs/apache2/albatros.local.conf /etc/apache2/sites-available/albatros.local.conf
RUN chmod +x /domains.sh /auto_alias.sh
RUN bash /auto_alias.sh

VOLUME /var/www/html
EXPOSE 22 80 3306 27017
