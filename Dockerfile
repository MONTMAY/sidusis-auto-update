# Wybieramy oficjalny obraz Alpine jako bazowy
FROM alpine:latest

# Instalacja curl
RUN apk update && \
    apk add --no-cache curl bash && \
    mkdir -p /var/log/cron

# Sprawdzenie, czy zmienna TOKEN jest ustawiona
ARG TOKEN
RUN if [ -z "$TOKEN" ]; then \
      echo "ERROR: TOKEN API is not set. Please set the TOKEN in the .env file."; \
      exit 1; \
    fi

# Konfiguracja crontaba
# Harmonogram: codziennie o 12:00
RUN echo "0 12 * * * curl --location --request PUT 'https://internet.gov.pl/api/statement/' \
    --header 'Accept: application/json' --header 'Content-Type: application/json' \
    --header 'Authorization: Token $TOKEN' --data '{\"are_up_to_date\": true}' >/var/log/cron/cron.log 2>&1" \
    > /etc/crontabs/root && \
    echo "0 12 * * * curl --location --request PUT 'https://internet.gov.pl/api/statement/investment_plans/' \
    --header 'Accept: application/json' --header 'Content-Type: application/json' \
    --header 'Authorization: Token $TOKEN' --data '{\"are_up_to_date\": true}' >/var/log/cron/cron.log 2>&1" \
    >> /etc/crontabs/root

# Uruchomienie crona w trybie foreground
CMD ["crond", "-f"]
