FROM resin/armhf-alpine:latest
# Original maintainer
#MAINTAINER Patrick Eichmann <phreakazoid@phreakazoid.com>
MAINTAINER Boris Manojlovic <boris@steki.net>

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.name="gitea-rpi" \
      org.label-schema.url="https://github.com/bmanojlovic/gitea-rpi" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/bmanojlovic/gitea-rpi.git" \
      org.label-schema.vcs-type="Git"

RUN [ "cross-build-start" ]

## SET NEWEST VERSION & DOWNLOAD URL
<<<<<<< HEAD
ENV VERSION 1.9.6
=======
ENV VERSION 1.9.6
>>>>>>> 7debff6e3314edb9655b8772f66fe8d7cb4e1764

RUN apk --no-cache add \
    gettext \
    su-exec \
    ca-certificates \
    sqlite \
    bash \
    git \
    subversion \
    linux-pam \
    s6 \
    curl \
    wget \
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
RUN svn export https://github.com/go-gitea/gitea/trunk/docker/root ./ --force

### GET GITEA GO FILE FOR RPI
RUN mkdir -p /app/gitea && \
    wget -O /app/gitea/gitea https://github.com/go-gitea/gitea/releases/download/v$VERSION/gitea-$VERSION-linux-arm-6 && \
    chmod 0755 /app/gitea/gitea

RUN [ "cross-build-end" ]

VOLUME ["/data"]

EXPOSE 22 3000

ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["/bin/s6-svscan", "/etc/s6"]
