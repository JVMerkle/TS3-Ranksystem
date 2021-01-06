FROM php:7.4-apache

RUN apt-get update && \
    apt-get install -y libzip-dev && \
    pecl install zip && \
    docker-php-ext-configure pdo_mysql && \
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-enable zip

RUN a2enmod remoteip
RUN echo "RemoteIPHeader X-Forwarded-For" >>/etc/apache2/apache2.conf

COPY docker-entrypoint.sh /usr/local/bin/

COPY . /var/www/html/ranksystem/
RUN rm /var/www/html/ranksystem/install.php
RUN chown www-data:www-data -R /var/www/html/ranksystem

USER www-data
CMD ["docker-entrypoint.sh"]
