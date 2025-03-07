FROM php:8.3-fpm

# PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# RUN pecl install xdebug && docker-php-ext-enable xdebug

COPY . /var/www/html
