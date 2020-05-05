FROM php:7.0-alpine

# Update packages and install required libraries and apps
RUN apk upgrade --update && apk add \
		bash \
		autoconf \
		g++ \
        make \
	    cyrus-sasl-dev \
        libmcrypt-dev \
        gmp-dev \
	    freetype-dev \
	    libpng-dev \
	    libjpeg-turbo-dev \
		postgresql-dev \
	    libmemcached-dev \

# Configure and install PHP extensions
    && docker-php-ext-configure \
        gd --with-freetype-dir=/usr/include/ \
           --with-jpeg-dir=/usr/include/ \
           --with-png-dir=/usr/include \
    && docker-php-ext-install \
        gd mbstring zip iconv mcrypt pdo_mysql pdo_pgsql bcmath \

# Download source of PHP extensions, build and install
## Memcached
    && curl -L https://github.com/php-memcached-dev/php-memcached/archive/php7.zip >> ./php7.zip \
	&& unzip php7.zip \
	&& ( \
		cd php-memcached-php7 \
		&& phpize \
		&& ./configure --disable-memcached-sasl \
		&& make \
		&& make install \
	) \
	&& rm -r php-memcached-php7 \
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
