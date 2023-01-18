# syntax=docker/dockerfile-upstream:master-labs
FROM node:16 as builder

ADD --keep-git-dir=false https://github.com/jakearchibald/svgomg.git#live /app

WORKDIR /app
RUN npm ci 
RUN npm run build

FROM halverneus/static-file-server:latest

EXPOSE 8080
ENV PORT=8080 \
	FOLDER=/app \
	CORS=true
COPY --from=builder /app/build /app

