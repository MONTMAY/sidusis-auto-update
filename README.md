# 🚀 SIDUSIS - Automatyczna aktualizacja zasięgu sieci i planów inwestycyjnych

Ten skrypt automatycznie aktualizuje oświadczenia o zasięgu sieci oraz planach inwestycyjnych w serwisie SIDUSIS. Działa na serwerze Linux, korzystając z `cron`, który codziennie o 12:00 wysyła oświadczenia do API SIDUSIS.

## 🛠️ Wymagania
- Serwer z systemem Linux 🐧
- Dostęp do terminala
- Konto w SIDUSIS z wygenerowanym tokenem API 🔑

## 📋 Instrukcja krok po kroku

1. **Wygeneruj token API SIDUSIS** 🔐:

   Zaloguj się do swojego konta SIDUSIS, przejdź do profilu i kliknij „Generuj token” w sekcji *Token REST API*. Zapisz token w bezpiecznym miejscu, ponieważ będzie potrzebny w kolejnych krokach.

2. **Uruchom skrypt konfiguracyjny** 🖥️:

   Skopiuj poniższe polecenie i wklej do terminala (SSH), zastępując `YOUR_API_TOKEN` wygenerowanym tokenem. Skrypt automatycznie skonfiguruje zadania `cron`, które codziennie o 12:00 zaktualizują zasięg sieci i plany inwestycyjne w SIDUSIS.

   ```bash
   TOKEN=YOUR_API_TOKEN && (echo "0 12 * * * curl --location --request PUT 'https://internet.gov.pl/api/statement/' --header 'Accept: application/json' --header 'Content-Type: application/json' --header 'Authorization: Token $TOKEN' --data '{\"are_up_to_date\": true}' >/dev/null 2>&1"; echo "0 12 * * * curl --location --request PUT 'https://internet.gov.pl/api/statement/investment_plans/' --header 'Accept: application/json' --header 'Content-Type: application/json' --header 'Authorization: Token $TOKEN' --data '{\"are_up_to_date\": true}' >/dev/null 2>&1") | crontab -

3. **Weryfikacja** ✅:

   Aby upewnić się, że zadania zostały dodane poprawnie, możesz wyświetlić swój crontab komendą:
   
   ```bash
   crontab -l
   ```
   
   Powinieneś zobaczyć linie podobne do poniższych:
   
   ```bash
   0 12 * * * curl --location --request PUT 'https://internet.gov.pl/api/statement/' --header 'Accept: application/json' --header 'Content-Type: application/json' --header 'Authorization: Token YOUR_API_TOKEN' --data '{"are_up_to_date": true}' >/dev/null 2>&1
   0 12 * * * curl --location --request PUT 'https://internet.gov.pl/api/statement/investment_plans/' --header 'Accept: application/json' --header 'Content-Type: application/json' --header 'Authorization: Token YOUR_API_TOKEN' --data '{"are_up_to_date": true}' >/dev/null 2>&1


## 📝 Uwagi
  * Token API jest kluczowy do autoryzacji żądań, więc jeśli token wygaśnie lub ulegnie zmianie, należy powtórzyć kroki, aby zaktualizować zadania cron.
  * Zadania te wysyłają dane wyłącznie w celach aktualizacji, więc błędy można sprawdzić w logach cron w systemie, np. /var/log/syslog lub /var/log/cron.log.

## 🔒 Bezpieczeństwo


Token API jest wrażliwy na dostęp i powinien być przechowywany bezpiecznie. Dla dodatkowego bezpieczeństwa można rozważyć użycie zmiennych środowiskowych lub menedżerów sekretów.

## 📄 Licencja

Ten projekt jest udostępniony na licencji MIT.
