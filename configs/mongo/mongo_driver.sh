#!/usr/bin/env bash
apt-get install php5-cli -y
apt-get install php5-dev -y
apt-get install php-pear -y
pecl install mongo
touch /etc/php5/cli/mongo.ini
echo 'extension=mongo.so' >> /etc/php5/cli/mongo.ini
echo 'extension=mongo.so' >> /etc/php5/cli/php.ini
echo "extension=mongo.so" | tee /etc/php5/apache2/conf.d/mongo.ini
