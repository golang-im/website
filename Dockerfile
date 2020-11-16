FROM alpine:latest AS builder

LABEL maintainer=chuiyouwu@gmail.com


RUN apk add --update git asciidoctor libc6-compat libstdc++ \
    && apk upgrade \
    && apk add --no-cache ca-certificates

ENV CADDY_VERSION =v2.0.0-beta.15

ADD https://github.com/caddyserver/caddy/releases/download/v2.0.0-beta.15/caddy2_beta15_linux_amd64 /tmp 

RUN   mv /tmp/caddy2_beta15_linux_amd64 /tmp/caddy


FROM alpine:latest as runner

WORKDIR /tmp

COPY --from=0 /tmp/caddy /usr/bin/caddy

COPY . .

RUN chmod +x /usr/bin/caddy

CMD caddy run -config ./Caddyfile --adapter caddyfile

EXPOSE 80