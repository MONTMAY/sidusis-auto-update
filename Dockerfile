# Dockerfile
FROM alpine:latest

# Zainstaluj wymagane pakiety
RUN apk update && \
    apk add --no-cache curl bash && \
    mkdir -p /var/log/cron

# Skopiuj skrypt entrypoint do kontenera
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
