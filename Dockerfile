FROM php:7.0-apache
MAINTAINER Tony Lea <tony.lea@thecontrolgroup.com>

EXPOSE 80

RUN docker-php-ext-install pdo pdo_mysql mysqli

RUN apt-get update && \
    apt-get install -qqy \
      libmcrypt-dev \
      git-core \
      zlib1g-dev && \
    docker-php-ext-install \
      bcmath \
      mbstring \
      mcrypt \
      zip

WORKDIR /var/www/html

ENV COMPOSER_HOME=/var/www/html

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

RUN 
  mysql -u root -e "CREATE DATABASE testdb" && \
  mysql -u root testdb < /var/www/html/storage/test_db.sql