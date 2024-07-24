FROM php:8.3-fpm

# Install necessary packages
RUN apt-get update && apt-get install -y \
    libmcrypt-dev \
    libpng-dev \
    mariadb-client \
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
    && docker-php-ext-install pdo_mysql

# Install and configure PHP extensions
RUN docker-php-ext-configure exif \
    && docker-php-ext-install exif \
    && docker-php-ext-enable exif

RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-webp=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# Install Xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Copy configuration files
COPY ./conf.d/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
COPY ./conf.d /usr/local/etc/php/conf.d/

# Create and use a non-root user
RUN groupadd -g 1000 www \
    && useradd -u 1000 -ms /bin/bash -g www www

# Set permissions for the working directory
WORKDIR /var/www/app
RUN chown -R www:www /var/www/app

# Copy application files
COPY --chown=www:www . /var/www/app

# Switch to non-root user
USER www
