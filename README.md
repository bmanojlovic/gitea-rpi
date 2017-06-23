# gitea-rpi
[![](https://images.microbadger.com/badges/image/phreakazoid/gitea-rpi:1.1.2.svg)](https://microbadger.com/images/phreakazoid/gitea-rpi:1.1.2 "Get your own image badge on microbadger.com")![](https://img.shields.io/docker/pulls/phreakazoid/gitea-rpi.svg)

This Dockerfile is for Automated Builds on Docker Hub.

## Usage with SQLite Database or External DB
```
$ docker run -d \
  --restart=always \
  --name=gitea-arm \
  -p 22:22 \
  -p 3000:3000 \
  -v /opt/gitea:/data \
  phreakazoid/gitea-rpi:1.1.2
```
## Usage with linked Database
```
$ docker run -d \
  --restart=always \
  --name=gitea-arm \
  --link mariadb:mysql \
  -p 22:22 \
  -p 3000:3000 \
  -v /opt/gitea:/data \
  phreakazoid/gitea-rpi:1.1.2
```
## Usage with custom options (for Example NGINX Proxy and Letsencrypt)
```
$ docker run -d \
  --restart=always \
  --name=gitea-arm \
  --link mariadb:mysql \
  -e VIRTUAL_HOST=git.sample.com \
  -e VIRTUAL_PORT=3000 \
  -e LETSENCRYPT_HOST=git.sample.com \
  -e LETSENCRYPT_EMAIL=info@sample.com \
  -p 22:22 \
  -p 3000:3000 \
  -v /opt/gitea:/data \
  phreakazoid/gitea-rpi:1.1.2
```
## Resources
* [Docker Hub](https://hub.docker.com/r/phreakazoid/gitea-rpi/)
* [Github](https://github.com/phreakazoid/gitea-rpi/)
