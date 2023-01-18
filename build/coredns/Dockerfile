FROM coredns/coredns as builder

FROM alpine:3.13.5

RUN apk --no-cache add ca-certificates
COPY --from=builder /coredns /usr/bin/coredns
WORKDIR /config

