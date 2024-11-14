#!/bin/sh

# Aktualizacja repozytoriów i instalacja zależności
apk update && \
apk add --no-cache tzdata curl cron

# Ustawienie strefy czasowej
cp /usr/share/zoneinfo/$TIMEZONE /etc/localtime
echo $TIMEZONE > /etc/timezone

# Dodanie zadań do crontab
echo "0 12 * * * curl --location --request PUT 'https://internet.gov.pl/api/statement/' --header 'Accept: application/json' --header 'Content-Type: application/json' --header 'Authorization: Token $API_TOKEN' --data '{\"are_up_to_date\": true}'" >> /etc/crontab
echo "0 12 * * * curl --location --request PUT 'https://internet.gov.pl/api/statement/investment_plans/' --header 'Accept: application/json' --header 'Content-Type: application/json' --header 'Authorization: Token $API_TOKEN' --data '{\"are_up_to_date\": true}'" >> /etc/crontab

# Uruchomienie crona
crond -f
