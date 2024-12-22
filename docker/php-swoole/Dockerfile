FROM php:8.3

RUN apt-get update && apt-get install -y \
    libpq-dev \
    libzip-dev \
    supervisor \
    libbrotli-dev \
    wget \
    git \
    && docker-php-ext-install pdo_pgsql zip \
    && pecl install redis swoole \
    && docker-php-ext-enable redis swoole \
    && docker-php-ext-install pcntl \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 www \
    && useradd -u 1000 -ms /bin/bash -g www www

WORKDIR /var/www/html

COPY --chown=www:www . .
COPY ./supervisor/*.conf /etc/supervisor/conf.d/

CMD ["/usr/bin/supervisord", "-n"]
