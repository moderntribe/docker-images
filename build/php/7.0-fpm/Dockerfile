# Use Alpine Linux
FROM alpine:latest
MAINTAINER Modern Tribe

# Environments
ENV TIMEZONE            Etc/UTC
ENV PHP_MEMORY_LIMIT    512M
ENV MAX_UPLOAD          50M
ENV PHP_MAX_FILE_UPLOAD 200
ENV PHP_MAX_POST        100M

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add --update tzdata && \
    cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone && \
    apk add --update \
        bash \
        curl \
        wget \
        grep \
        php7 \
        php7-common \
        php7-mcrypt \
        php7-soap \
        php7-openssl \
        php7-gmp \
        php7-pdo_odbc \
        php7-json \
        php7-dom \
        php7-pdo \
        php7-zip \
        php7-mysqli \
        php7-sqlite3 \
        php7-pdo_pgsql \
        php7-bcmath \
        php7-gd \
        php7-odbc \
        php7-pdo_mysql \
        php7-pdo_sqlite \
        php7-gettext \
        php7-xmlreader \
        php7-xmlrpc \
        php7-bz2 \
        php7-iconv \
        php7-pdo_dblib \
        php7-curl \
        php7-ctype \
        php7-imap \
        php7-mbstring \
        php7-posix \
        php7-session \
        php7-memcached \
        php7-xdebug \
        php7-phar \
        php7-fpm && \

    ln -s /usr/bin/php7 /usr/bin/php && \

    # Cleaning up
    mkdir /www && \
    apk del tzdata && \
    rm -rf /var/cache/apk/*
    
    # Set environments
RUN sed -i "s|;*daemonize\s*=\s*yes|daemonize = no|g" /etc/php7/php-fpm.conf && \
    sed -i "s|;*listen\s*=\s*127.0.0.1:9000|listen = 9000|g" /etc/php7/php-fpm.conf && \
    sed -i "s|;*listen\s*=\s*127.0.0.1:9000|listen = 9000|g" /etc/php7/php-fpm.d/www.conf && \
    sed -i "s|;*listen\s*=\s*/||g" /etc/php7/php-fpm.conf && \
    sed -i "s|;catch_workers_output\s*=\s*yes|catch_workers_output = yes|i" /etc/php7/php-fpm.conf && \
    sed -i "s|;catch_workers_output\s*=\s*yes|catch_workers_output = yes|i" /etc/php7/php-fpm.d/www.conf && \
    sed -i "s|;clear_env\s*=\s*no|clear_env = no|i" /etc/php7/php-fpm.conf && \
    sed -i "s|;?error_log\s*=.*|error_log = /dev/stdout|i" /etc/php7/php-fpm.conf && \

    sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" /etc/php7/php.ini && \
    sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini && \
    sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|i" /etc/php7/php.ini && \
    sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php7/php.ini && \
    sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php7/php.ini && \
    sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0|i" /etc/php7/php.ini && \
    sed -i "s|;*display_errors =.*|display_errors = on|i" /etc/php7/php.ini && \
    sed -i "s|;*display_startup_errors =.*|display_startup_errors = on|i" /etc/php7/php.ini && \
    sed -i "s|;*error_reporting =.*|error_reporting = -1|i" /etc/php7/php.ini && \

    echo "xdebug.remote_enable=1" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.remote_autostart=0" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.remote_connect_back=1" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.remote_port=9000" >> /etc/php7/conf.d/xdebug.ini && \
    echo "xdebug.force_display_errors=1" >> /etc/php7/conf.d/xdebug.ini


# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# WP CLI
RUN echo "installing WP-CLI" \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Set Workdir
WORKDIR /srv/www

# Expose ports
EXPOSE 9000

CMD ["/usr/sbin/php-fpm7"]