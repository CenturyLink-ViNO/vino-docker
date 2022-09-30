FROM nginx

ADD vino-core/web /opt/vino/vino-core/web

RUN rm -f /etc/nginx/conf.d/default.conf

RUN mkdir -p /opt/vino/conf

ADD vino-core/etc/docker/common/nginx_docker_entrypoint.sh /opt/vino/docker_entrypoint.sh
ADD vino-core/etc/docker/nginx /opt/vino/conf/nginx
ADD vino-core/etc/docker/nginx.ssl /opt/vino/conf/nginx.ssl

RUN chmod +x /opt/vino/docker_entrypoint.sh

ENTRYPOINT ["/opt/vino/docker_entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]