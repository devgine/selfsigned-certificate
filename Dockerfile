ARG GO_VERSION=1.13-alpine
ARG ALPINE_VERSION=3.19

FROM golang:$GO_VERSION AS build
RUN apk add --no-cache git
RUN go get github.com/jsha/minica

FROM alpine:$ALPINE_VERSION
COPY --from=build /go/bin/minica /usr/local/bin/minica

RUN apk add --no-cache openssl

COPY certs.sh /usr/local/bin/docker-certs
RUN chmod +x /usr/local/bin/docker-certs

## ClEAN
RUN rm -rf /tmp/* /var/cache/apk/* /var/tmp/*

WORKDIR /certs

ENTRYPOINT ["docker-certs"]


## LABELS
ARG VCS_REF
ARG BUILD_VERSION
ARG BUILD_DATE
ARG IMAGE_TAG=ghcr.io/devgine/composer-php:latest

LABEL maintainer="yosribahri@gmail.com"
LABEL org.opencontainers.image.title="Self-signed certificate docker image"
LABEL org.opencontainers.image.description="This is a docker image that generate a TLS self signed certificate based on mimica library."
LABEL org.opencontainers.image.source="https://github.com/devgine/selfsigned-certificate"
LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.created=$BUILD_DATE
LABEL org.opencontainers.image.url="https://github.com/devgine/selfsigned-certificate"
LABEL org.opencontainers.image.version=$BUILD_VERSION
LABEL org.opencontainers.image.revision=$VCS_REF
LABEL org.opencontainers.image.vendor="devgine"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.name="devgine/selfsigned-certificate"
LABEL org.label-schema.description="This is a docker image that generate a TLS self signed certificate based on mimica library."
LABEL org.label-schema.url="https://github.com/devgine/selfsigned-certificate"
LABEL org.label-schema.vcs-url="https://github.com/devgine/selfsigned-certificate"
LABEL org.label-schema.vcs-ref=$VCS_REF
LABEL org.label-schema.version=$BUILD_VERSION
LABEL org.label-schema.docker.cmd="docker run --rm -v /certs:/certs $IMAGE_TAG -d WWW.DOMAIN.COM"
LABEL org.label-schema.vendor="devgine"
