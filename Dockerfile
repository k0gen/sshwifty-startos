FROM niruix/sshwifty:0.3.12-beta-release

USER root
RUN apk add --no-cache yq; \
    rm -f /var/cache/apk/*; \
    rm -rf /sshwifty-src

ADD ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod a+x /usr/local/bin/docker_entrypoint.sh
