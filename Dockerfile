FROM mediawiki:1.43

RUN apt-get update && apt-get install --yes curl libpq-dev tar unzip

ENV PLUGGABLE_AUTH_VERSION=REL1_43-b9a8782
ENV OPENID_CONNECT_VERSION=REL1_43-953d604

RUN export archive=PluggableAuth-${PLUGGABLE_AUTH_VERSION}.tar.gz && \
    curl --location --silent --output /tmp/${archive} https://extdist.wmflabs.org/dist/extensions/${archive} && \
    tar --extract --gzip --file /tmp/${archive} --directory /var/www/html/extensions && \
    rm /tmp/${archive}

RUN export archive=OpenIDConnect-${OPENID_CONNECT_VERSION}.tar.gz && \
    curl --location --silent --output /tmp/${archive} https://extdist.wmflabs.org/dist/extensions/${archive} && \
    tar --extract --gzip --file /tmp/${archive} --directory /var/www/html/extensions && \
    rm /tmp/${archive}

WORKDIR /var/www/html

RUN echo '{ "extra": { "merge-plugin": { "include": [ "extensions/OpenIDConnect/composer.json" ] } } }' \
    > /var/www/html/composer.local.json && \
    php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');" && \
    php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    composer update

RUN rm -rf /tmp/composer-setup.php
