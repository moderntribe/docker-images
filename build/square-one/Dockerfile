FROM moderntribe/wordpress:nginx-php7-fpm

COPY ./ /srv/site
RUN chown -R nginx:nginx /srv/site
RUN cd /srv/site && \
    npm set progress=false && \
    npm install && \
    grunt
