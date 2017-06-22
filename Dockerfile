#FROM multiarch/alpine:armhf-v3.5
FROM resin/armhf-alpine:latest
MAINTAINER Patrick Eichmann <phreakazoid@phreakazoid.com>

## SET NEWEST VERSION & DOWNLOAD URL
ENV VERSION 1.1.2
ENV DOWNLOAD_URL https://github.com/go-gitea/gitea/releases/download/v$VERSION/gitea-$VERSION-linux-arm-7

RUN [ "cross-build-start" ]

RUN apk --no-cache add \
    su-exec \
    ca-certificates \
    sqlite \
    bash \
    git \
    subversion \
    linux-pam \
    s6 \
    curl \
    openssh \
    tzdata
RUN addgroup \
    -S -g 1000 \
    git && \
  adduser \
    -S -H -D \
    -h /data/git \
    -s /bin/bash \
    -u 1000 \
    -G git \
    git && \
  echo "git:$(date +%s | sha256sum | base64 | head -c 32)" | chpasswd

ENV USER git
ENV GITEA_CUSTOM /data/gitea
ENV GODEBUG=netdns=go

## GET DOCKER FILES
RUN svn export https://github.com/go-gitea/gitea/trunk/docker ./ --force

### GET GITEA GO FILE FOR RPI
RUN wget -qO- $DOWNLOAD_URL | -C /app/gitea/gitea

RUN [ "cross-build-end" ]

VOLUME ["/data"]

EXPOSE 22 3000

ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["/bin/s6-svscan", "/etc/s6"]
