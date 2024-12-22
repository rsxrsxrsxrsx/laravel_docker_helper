FROM php:8.3-fpm

RUN apt-get update && apt-get install -y \
    libmcrypt-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libgd-dev \
    libedit-dev \
    libreadline-dev \
    wget \
    unzip \
    curl \
    jpegoptim \
    optipng \
    pngquant \
    gifsicle \
    libavif-bin \
    libpq-dev \
    libzip-dev && \
    docker-php-ext-install pdo_pgsql zip

RUN pecl install redis \
    && docker-php-ext-enable redis

RUN docker-php-ext-configure exif \
    && docker-php-ext-install exif \
    && docker-php-ext-enable exif

RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-webp=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

COPY ./conf.d /usr/local/etc/php/conf.d/

RUN groupadd -g 1000 www \
    && useradd -u 1000 -ms /bin/bash -g www www

WORKDIR /var/www/html
RUN chown -R www:www /var/www/html

COPY --chown=www:www . /var/www/html

USER www
