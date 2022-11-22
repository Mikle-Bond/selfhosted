FROM caddy:2.5.1-builder-alpine as builder
ENV http_proxy=70.184.195.197:80
ENV https_proxy=136.226.32.241:443

RUN xcaddy build --with github.com/caddy-dns/duckdns

FROM caddy:2.5.1

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

