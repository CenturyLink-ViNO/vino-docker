FROM node:9

WORKDIR /opt/vino/vino-core

RUN mkdir -p /opt/abacus/etc

ADD vino-core ./
ADD *.properties /opt/abacus/etc/
ADD vino-core/etc/docker/common /opt/vino/common

RUN echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list
RUN apt-get update -qq; exit 0
RUN apt-get install -y build-essential --force-yes
RUN apt-get install -y software-properties-common --force-yes
RUN apt-get install -y ansible --force-yes
RUN apt-get install -y dos2unix --force-yes

RUN find /opt/vino -name "*.sh" -exec dos2unix {} \;

RUN sed -i '/host_key_checking.*$/c\host_key_checking = False' /etc/ansible/ansible.cfg
RUN sed -i '/gathering =.*$/c\gathering = explicit' /etc/ansible/ansible.cfg
RUN sed -i '/StrictHostKeyChecking.*$/c\StrictHostKeyChecking no' /etc/ssh/ssh_config
RUN sed -i "\$aUserKnownHostsFile \/dev\/null" /etc/ssh/ssh_config

RUN npm install express
RUN npm install node-red@0.20.5 -g --unsafe-perm
RUN npm install forever -g
RUN npm install ts-node -g
RUN npm install @exlinc/keycloak-passport
RUN mkdir -p /var/log/vino

RUN mkdir ./libraries

RUN cp -R ./web/lib/abacus-ots/swagger-ui ./libraries

RUN chmod +x /opt/vino/common/docker_entrypoint.sh
RUN chmod +x /opt/vino/common/wait-for-postgres.sh

RUN npm install .

WORKDIR /opt/vino/vino-core/nodes

RUN npm install .

WORKDIR /opt/vino/vino-core/nodes/abacus

RUN npm install .

WORKDIR /opt/vino/vino-core

EXPOSE 3000

ENTRYPOINT ["/opt/vino/common/docker_entrypoint.sh"]

CMD ["forever", "-c", "node --max_old_space_size=8192", "vino-core.json"]
