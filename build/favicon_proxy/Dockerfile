# syntax=docker/dockerfile-upstream:master-labs
FROM node
WORKDIR /app

ADD --keep-git-dir=false https://github.com/Mikle-Bond/favicon-proxy.git /app
RUN npm ci 
ENTRYPOINT ["node"]
CMD ["index.js"]

