FROM caddy:2.6.2-builder as builder
ARG GOPROXY=https://proxy.golang.org,direct

RUN xcaddy build \
	--with github.com/lucaslorentz/caddy-docker-proxy/v2 \
	--with github.com/caddy-dns/duckdns

FROM caddy:2.6.2

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

CMD ["caddy", "docker-proxy"]

