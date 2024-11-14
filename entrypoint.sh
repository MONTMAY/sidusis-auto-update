#!/bin/bash

# Konfiguracja zadania cron z dwoma wpisami
echo "0 12 * * * curl --location --request PUT 'https://internet.gov.pl/api/statement/' --header 'Accept: application/json' --header 'Content-Type: application/json' --header 'Authorization: Token $TOKEN' --data '{\"are_up_to_date\": true}' >/dev/null 2>&1" > /etc/crontabs/root
echo "0 12 * * * curl --location --request PUT 'https://internet.gov.pl/api/statement/investment_plans/' --header 'Accept: application/json' --header 'Content-Type: application/json' --header 'Authorization: Token $TOKEN' --data '{\"are_up_to_date\": true}' >/dev/null 2>&1" >> /etc/crontabs/root

# Uruchomienie crond
crond -f
