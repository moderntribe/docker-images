FROM nginx:alpine
MAINTAINER Modern Tribe

# Environments
ENV TIMEZONE Etc/UTC

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
        php7-phar \
        php7-fpm && \

    # Cleaning up
    mkdir /www && \
    apk del tzdata && \
    rm -rf /var/cache/apk/*

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# WP CLI
RUN echo "installing WP-CLI" \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Nginx
RUN apk --update add git

RUN rm -rf /etc/nginx
RUN git clone https://github.com/h5bp/server-configs-nginx /etc/nginx
COPY fastcgi_params /etc/nginx/fastcgi_params
COPY nginx.conf /etc/nginx/nginx.conf
COPY wordpress.conf /etc/nginx/wordpress.conf
RUN rm -rf /etc/nginx/sites-available
RUN rm -rf /etc/nginx/sites-enabled
RUN mkdir /etc/nginx/sites-enabled
COPY site.conf /etc/nginx/sites-enabled/site.conf
RUN mkdir -p /srv/logs
COPY cmd.sh /usr/local/bin/dockerfile-cmd.sh
RUN chmod +x /usr/local/bin/dockerfile-cmd.sh

# Expose ports
EXPOSE 80

CMD ["/usr/local/bin/dockerfile-cmd.sh"]

