#!/usr/bin/env sh

echo 'start';

#composer install --no-interaction;

#php artisan optimize:clear

php-fpm -y /usr/local/etc/php-fpm.conf -R