FROM php:8.2.4-fpm-alpine3.16

ARG UID
ARG GID

ENV UID=${UID}
ENV GID=${GID}

RUN curl -sfL https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
    chmod +x /usr/bin/composer && \
    composer self-update --2 --clean-backups

# build-essentials
RUN apk update && \
    apk add --no-cache $PHPIZE_DEPS linux-headers \
      icu-dev icu-libs automake libstdc++ libpq openssl-dev pcre-dev pcre2-dev zlib-dev libzip-dev curl-dev \
      libpng-dev libwebp-dev libjpeg-turbo-dev freetype-dev

RUN pecl update-channels

# MacOS staff group's gid is 20, so is the dialout group in alpine linux. We're not using it, let's just remove it.
RUN delgroup dialout
RUN addgroup -g ${GID} --system evolution
RUN adduser -G evolution --system -D -s /bin/sh -u ${UID} evolution

RUN sed -i "s/user = www-data/user = evolution/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = evolution/g" /usr/local/etc/php-fpm.d/www.conf
RUN echo "php_admin_flag[log_errors] = on" >> /usr/local/etc/php-fpm.d/www.conf

RUN docker-php-ext-install pdo pdo_mysql bcmath \
    && docker-php-ext-enable bcmath

RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install gd zip \
    && docker-php-ext-enable gd zip

RUN pecl install redis && \
    docker-php-ext-enable redis && \
    docker-php-ext-install pcntl

RUN pecl install xdebug && \
    docker-php-ext-enable xdebug

RUN rm -rf $HOME/.composer/*-old.phar && \
    docker-php-source delete

# Configure entrypoint
COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER evolution

RUN mkdir -p /var/www/html
WORKDIR /var/www/html

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
