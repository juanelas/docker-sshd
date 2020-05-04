FROM alpine:latest

RUN apk add --no-cache \
    openssh

COPY ./config/sshd_config /etc/ssh/sshd_config
COPY ./bin/* /usr/local/bin/

VOLUME [ "/home", "/opt/sshd" ]

ENTRYPOINT [ "docker-entrypoint.sh" ]
