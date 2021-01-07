FROM php:7.4-apache

RUN apt-get update && \
    apt-get install -y libzip-dev && \
    pecl install zip && \
    docker-php-ext-configure pdo_mysql && \
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-enable zip && \
    rm -rf /var/lib/apt/lists/*

RUN a2enmod remoteip rewrite
RUN ( \
        echo "RemoteIPHeader X-Forwarded-For" && \
        echo "ErrorLog /dev/null" && \
        echo "CustomLog /dev/null combined" \
    ) >>/etc/apache2/apache2.conf

COPY docker-entrypoint.sh /

COPY . /var/www/ranksystem/
RUN mkdir /var/www/tsicons
RUN chown www-data:www-data -R /var/www

USER www-data
CMD ["/bin/sh", "/docker-entrypoint.sh"]
