FROM postgres:10.4

ADD vino-core /opt/vino/vino-core
ADD abacus-postgres /opt/abacus/abacus-postgres

RUN /usr/sbin/useradd vino
RUN /bin/echo vino:vino | /usr/sbin/chpasswd

RUN /usr/sbin/useradd abacus
RUN /bin/echo abacus:abacus | /usr/sbin/chpasswd

# Add the sudo and java packages, required for our scripts
RUN apt-get update && apt-get install -y sudo openjdk-8-jre openjdk-8-jdk --force-yes && rm -rf /var/lib/apt/lists/*
RUN sh -c "echo \"postgres        ALL=(ALL)       NOPASSWD: ALL\" >> /etc/sudoers"

# Fix path difference between Centos 7 and the OS that the postgres container runs on
RUN ln -s /usr/bin/find /bin/find

RUN /bin/sed -i '/exec "$@"/d' /usr/local/bin/docker-entrypoint.sh

RUN find /opt/abacus/abacus-postgres/etc/pgsql -name "*.sql" -type f -exec cp {} /docker-entrypoint-initdb.d/ \;
RUN find /opt/vino/vino-core/etc/pgsql -name "*.sql" -type f -exec cp {} /docker-entrypoint-initdb.d/ \;
RUN find /opt/vino/vino-core/etc/docker -name "*.sql" -type f -exec cp {} /docker-entrypoint-initdb.d/ \;

RUN chmod +x /opt/vino/vino-core/etc/docker/setup-docker-db.sh

USER postgres:postgres

ENTRYPOINT ["/opt/vino/vino-core/etc/docker/setup-docker-db.sh"]

CMD ["postgres"]
