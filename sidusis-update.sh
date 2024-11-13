#!/bin/sh

# Ustawiamy strefę czasową w kontenerze
apk add --no-cache tzdata
cp /usr/share/zoneinfo/$TIMEZONE /etc/localtime
echo "$TIMEZONE" > /etc/timezone
apk del tzdata

# Sprawdzamy, czy token API jest ustawiony
if [ -z "$TOKEN" ]; then
  echo "API token is not set. Exiting..."
  exit 1
fi

# Zadania aktualizacji zasięgu sieci
curl --location --request PUT 'https://internet.gov.pl/api/statement/' \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json' \
  --header "Authorization: Token $TOKEN" \
  --data '{"are_up_to_date": true}' >/dev/null 2>&1

# Zadania aktualizacji planów inwestycyjnych
curl --location --request PUT 'https://internet.gov.pl/api/statement/investment_plans/' \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json' \
  --header "Authorization: Token $TOKEN" \
  --data '{"are_up_to_date": true}' >/dev/null 2>&1
