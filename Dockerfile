# Wybieramy oficjalny obraz Alpine jako bazowy
FROM alpine:latest

# Instalacja wymaganych zależności (dcron, curl, tzdata)
RUN apk update && \
    apk add --no-cache dcron curl bash tzdata && \
    cp /usr/share/zoneinfo/Europe/Warsaw /etc/localtime && \
    echo "Europe/Warsaw" > /etc/timezone

# Kopiowanie skryptu entrypoint.sh do kontenera
COPY entrypoint.sh /entrypoint.sh

# Ustawianie uprawnień do skryptu entrypoint.sh
RUN chmod +x /entrypoint.sh

# Skrypt zostanie uruchomiony przy starcie kontenera
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]

# Uruchomienie cron w trybie foreground
CMD ["crond", "-f"]