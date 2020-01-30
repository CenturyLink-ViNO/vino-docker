FROM jboss/keycloak:4.4.0.Final

USER root
RUN mkdir -p /opt/vino/config/
RUN yum install -y nc
ADD vino-core/etc/docker/common/keycloak_docker_entrypoint.sh /opt/jboss/startup-scripts/db_wait.sh

RUN chmod +x /opt/jboss/startup-scripts/db_wait.sh

CMD ["-b", "0.0.0.0", "-Dkeycloak.migration.action=import" , "-Dkeycloak.migration.provider=dir", "-Dkeycloak.migration.dir=/opt/vino/config", "-Dkeycloak.migration.strategy=IGNORE_EXISTING"]
