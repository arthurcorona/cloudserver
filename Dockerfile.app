FROM nextcloud:stable-fpm-alpine

RUN apk update && \
    apk add --no-cache \
    build-base \
    cmake \
    git \
    imagemagick-dev \
    ffmpeg \
    nodejs \
    npm

RUN docker-php-ext-install pdo pdo_mysql opcache
RUN if ! pecl list | grep -q imagick; then \
        pecl install imagick && \
        docker-php-ext-enable imagick; \
    fi
