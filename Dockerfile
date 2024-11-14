# Wybieramy oficjalny obraz Alpine jako bazowy
FROM alpine:latest

# Instalacja dcron, curl
RUN apk update && \
    apk add --no-cache dcron curl bash && \
    mkdir /var/log/cron

# Ustawienie zmiennej TOKEN i konfiguracja crontaba
# Harmonogram: codziennie o 12:00
ARG TOKEN
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
