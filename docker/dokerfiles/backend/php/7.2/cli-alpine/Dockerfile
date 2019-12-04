FROM php:7.2-alpine

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
        gd mbstring zip iconv pdo_mysql pdo_pgsql bcmath \

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

# MaxMind GeoIP DB Lib
    && curl -L https://github.com/maxmind/libmaxminddb/releases/download/1.2.0/libmaxminddb-1.2.0.tar.gz >> ./libmaxminddb-1.2.0.tar.gz \
    && tar -xf libmaxminddb-1.2.0.tar.gz \
    && ( \
   		cd libmaxminddb* \
    	&& ./configure \
    	&& make \
    	&& make install \
    ) \
    && rm -r libmaxminddb* \

# MaxMind GeoIP Reader
    && curl -L https://github.com/maxmind/MaxMind-DB-Reader-php/archive/v1.1.0.tar.gz >> ./MaxMind-DB-Reader-php-1.1.0.tar.gz \
    && tar -xf MaxMind-DB-Reader-php-1.1.0.tar.gz \
    && ( \
        cd MaxMind-DB-Reader-php-*/ext \
        && cp /usr/local/include/maxminddb.h ./maxminddb.h \
        && cp /usr/local/include/maxminddb_config.h ./maxminddb_config.h \
        && phpize \
        && ./configure \
        && make \
        && make install \
    ) \
    && rm -r MaxMind-DB-Reader* \
    && docker-php-ext-enable maxminddb \

# Install MaxMind GeoIP Databases
    && curl -L http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz >> GeoLite2-City.mmdb.gz \
    && curl -L http://geolite.maxmind.com/download/geoip/database/GeoLite2-Country.mmdb.gz >> GeoLite2-Country.mmdb.gz \
    && gunzip GeoLite2-City.mmdb.gz \
    && gunzip GeoLite2-Country.mmdb.gz \
    && mkdir /usr/local/share/GeoIP \
    && mv GeoLite2-City.mmdb /usr/local/share/GeoIP \
    && mv GeoLite2-Country.mmdb /usr/local/share/GeoIP \
	&& rm -rf /var/cache/apk/* \

# Make project directory
   && mkdir -p /srv/www/html

WORKDIR "/srv/www/html"
