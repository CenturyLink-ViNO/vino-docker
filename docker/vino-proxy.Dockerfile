FROM nginx

ADD vino-core/web /opt/vino/vino-core/web

RUN rm -f /etc/nginx/conf.d/default.conf

ADD vino-core/etc/docker/nginx/conf.d/* /etc/nginx/conf.d
ADD vino-core/etc/docker/nginx/default.d /etc/nginx/default.d
