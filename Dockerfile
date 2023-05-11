FROM php:8.2-apache

RUN apt-get update && \
    apt-get install -y libcap2-bin tini libzip-dev && \
    pecl install zip && \
    docker-php-ext-configure pdo_mysql && \
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-enable zip && \
    rm -rf /var/lib/apt/lists/*

# Allow apache to bind to port 80 with any user
# Use the PHP production settings.
# Accept X-Forwarded-For as real client ip from a TRUSTED PROXY.
# Set the "Server" header to production (e.g. to "Apache") and
# remove apache version information. Build the ETAG from
# last modified and size only.
RUN setcap 'cap_net_bind_service=+ep' /usr/sbin/apache2 && \
    mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" && \
    a2enmod remoteip && \
    ( \
        echo "RemoteIPHeader X-Forwarded-For" && \
        echo "ServerTokens Prod" && \
        echo "ServerSignature Off" && \
        echo "TraceEnable off" && \
        echo "FileETag MTime Size" && \
        echo "ErrorLog /dev/null" && \
        echo "CustomLog /dev/null combined" \
    ) >>/etc/apache2/apache2.conf

COPY . /var/www/ranksystem/

RUN mv /var/www/ranksystem/docker-entrypoint.sh /docker-entrypoint.sh && \
    mkdir /var/www/tsicons && \
    chown www-data:www-data -R /var/www

USER www-data
WORKDIR /
ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["/bin/sh", "/docker-entrypoint.sh"]
