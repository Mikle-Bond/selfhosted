ARG IMAGE
FROM ${IMAGE}

ARG ENTRYPOINT="/bin/sh -c"
ENV ENTRYPOINT="${ENTRYPOINT}"
ENTRYPOINT [ "/docker-entrypoint-pre.sh"]
COPY docker-entrypoint-pre.sh /
COPY docker-entrypoint.d /docker-entrypoint.d/

