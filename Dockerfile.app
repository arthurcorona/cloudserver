FROM nextcloud:stable-fpm-alpine

RUN apk update && apk add --no-cache \
    build-base \
    cmake \
    git \
    imagemagick-dev \
    ffmpeg \
    nodejs \
    npm \
    php8-pecl-imagick \
    php8-pdo \
    php8-pdo_mysql \
    php8-opcache \
    icu-dev \
    libxml2-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    libxpm-dev \
    libzip-dev \
    freetype-dev \
    zlib-dev

# Habilitando extensões PHP
RUN docker-php-ext-install \
    pdo \
    pdo_mysql \
    opcache

# Habilitando o imagick 
RUN if ! php -m | grep -qi imagick; then \
        pecl install imagick && \
        docker-php-ext-enable imagick; \
    fi

# Limpeza do cache
RUN rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

