FROM caddy:2.4.6-builder-alpine as builder

RUN xcaddy build --with github.com/caddy-dns/duckdns

FROM caddy:2.4.6

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

