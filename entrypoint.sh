#!/bin/sh

# Sprawdzenie, czy TOKEN jest ustawiony
if [ -z "$TOKEN" ]; then
  echo "ERROR: TOKEN API is not set. Please set the TOKEN in the .env file."
  exit 1
fi

# Dodanie zadań do crontaba
echo "0 12 * * * curl --location --request PUT 'https://internet.gov.pl/api/statement/' --header 'Accept: application/json' --header 'Content-Type: application/json' --header 'Authorization: Token $TOKEN' --data '{\"are_up_to_date\": true}' >/dev/null 2>&1" | crontab -
echo "0 12 * * * curl --location --request PUT 'https://internet.gov.pl/api/statement/investment_plans/' --header 'Accept: application/json' --header 'Content-Type: application/json' --header 'Authorization: Token $TOKEN' --data '{\"are_up_to_date\": true}' >/dev/null 2>&1" | crontab -

# Uruchom cron w trybie pierwszoplanowym
crond -f
