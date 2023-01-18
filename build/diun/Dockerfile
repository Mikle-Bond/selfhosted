FROM crazymax/diun as upstream

FROM ghcr.io/linuxserver/baseimage-alpine:3.17

RUN true \
	&& apk update \
	&& apk --upgrade add ca-certificates openssl \
	&& apk add curl \
	&& rm -rf /var/cache/apk/*

COPY --from=upstream /usr/local/bin/diun /usr/local/bin/diun

ENV PROFILER_PATH="/profiler" \
  DIUN_DB_PATH="/data/diun.db"

VOLUME [ "/data" ]
CMD [ "diun", "serve" ]

