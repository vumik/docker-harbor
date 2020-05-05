FROM php:7.4-fpm-alpine

# Update packages and install required libraries and apps
RUN apk upgrade --update && apk add \
		bash \
		autoconf \
		g++ \
        make \
	    cyrus-sasl-dev \
        gmp-dev \
	    freetype-dev \
	    libpng-dev \
	    libjpeg-turbo-dev \
	    libxpm-dev \
	    libwebp-dev \
		postgresql-dev \
	    libmemcached-dev \
        libzip-dev \
        oniguruma-dev \

# Configure and install PHP extensions
    && docker-php-ext-configure \
        gd --enable-gd          \
           --with-webp          \
           --with-jpeg          \
           --with-xpm           \
           --with-freetype      \
    && docker-php-ext-install   \
        gd mbstring zip iconv pdo_mysql pdo_pgsql bcmath \

# Download source of PHP extensions, build and install
## Memcached
    && pecl download memcached \
	&& tar -xf memcached-* \
	&& ( \
		cd memcached-3.1.5 \
		&& phpize \
		&& ./configure --disable-memcached-sasl \
		&& make \
		&& make install \
	) \
	&& rm -r memcached-3.1.5 \
	&& docker-php-ext-enable memcached \

## Xdebug
    && pecl download xdebug \
	&& tar -xf xdebug-* \
	&& ( \
		cd xdebug-* \
		&& phpize \
		&& ./configure \
		&& make \
		&& make install \
	) \
	&& rm -r xdebug-* \
	&& docker-php-ext-enable xdebug \

## Redis
    && pecl download redis \
	&& tar -xf redis-* \
	&& ( \
		cd redis-* \
		&& phpize \
		&& ./configure \
		&& make \
		&& make install \
	) \
	&& rm -r redis-* \
	&& docker-php-ext-enable redis \

	&& rm -rf /var/cache/apk/* \

# Make project directory
   && mkdir -p /srv/www/html

WORKDIR "/srv/www/html"
