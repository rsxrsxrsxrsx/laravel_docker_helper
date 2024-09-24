FROM php:8.3-fpm

# Установить необходимые пакеты
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

# Установить расширение Redis
RUN pecl install redis \
    && docker-php-ext-enable redis

# Установить и настроить PHP расширения
RUN docker-php-ext-configure exif \
    && docker-php-ext-install exif \
    && docker-php-ext-enable exif

RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-webp=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# Установить Composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# Установить Xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Скопировать конфигурационные файлы
COPY ./conf.d/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
COPY ./conf.d /usr/local/etc/php/conf.d/

# Создать и использовать пользователя без прав администратора
RUN groupadd -g 1000 www \
    && useradd -u 1000 -ms /bin/bash -g www www

# Установить права на рабочую директорию
WORKDIR /var/www/app
RUN chown -R www:www /var/www/app

# Скопировать файлы приложения
COPY --chown=www:www . /var/www/app

# Переключиться на пользователя без прав администратора
USER www
