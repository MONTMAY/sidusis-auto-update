# 🚀 SIDUSIS - Automatyczna aktualizacja zasięgu sieci i planów inwestycyjnych

Ten skrypt automatycznie aktualizuje oświadczenia o zasięgu sieci oraz planach inwestycyjnych w serwisie SIDUSIS. Działa na serwerze Linux, korzystając z `cron`, który codziennie o 12:00 wysyła oświadczenia do API SIDUSIS.

## 🛠️ Wymagania

### System operacyjny:
- **Linux**: Skrypt działa na większości dystrybucji Linuxa, takich jak:
  - Ubuntu / Debian
  - CentOS / RHEL
  - Fedora
  - Arch Linux
  - openSUSE
  - inne dystrybucje zgodne z Unixem
  
  Skrypt wykorzystuje narzędzie **cron**, które jest standardowo dostępne w tych systemach.

- **macOS**: Skrypt działa także na systemie macOS, który jest oparty na Unixie i wspiera `cron`.

- **WSL (Windows Subsystem for Linux)**: Jeśli używasz systemu Windows, możesz uruchomić skrypt w środowisku **WSL**, które pozwala na korzystanie z systemu Linux na Windowsie.

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

## 🔧 Plany na przyszłe aktualizacje 

W nadchodzących aktualizacjach planujemy dodać dodatkową funkcjonalność i ułatwienia, aby skrypt i jego konfiguracja były jeszcze łatwiejsze do użycia. Oto, co planujemy:

  * Obsługa Docker 🚢
        Dodamy możliwość uruchomienia skryptu w kontenerze Docker. Dzięki temu użytkownicy będą mogli łatwo uruchomić skrypt w izolowanym środowisku, bez konieczności ręcznej konfiguracji na systemie operacyjnym.
        Docker zapewni prostsze zarządzanie środowiskiem, a także łatwiejszą migrację i wdrożenie w różnych systemach.

  * Plik docker-compose.yml ⚙️
        Wprowadzimy plik docker-compose.yml, który umożliwi łatwe uruchomienie kontenera za pomocą jednej komendy. Użytkownicy będą mogli za pomocą docker-compose up szybko uruchomić skrypt w Dockerze z minimalną konfiguracją.
        Dzięki temu proces instalacji i konfiguracji zostanie uproszczony, a uruchamianie aplikacji stanie się bardziej uniwersalne.

Dalsze plany:

  * Zwiększenie elastyczności konfiguracji (np. poprzez plik .env).
  * Możliwość skonfigurowania harmonogramu dla różnych zadań lub interwałów czasowych.

Dzięki tym aktualizacjom projekt stanie się jeszcze bardziej dostępny i łatwiejszy w użyciu, zwłaszcza w środowiskach, gdzie Docker jest preferowaną metodą wdrożenia.

## 📄 Licencja

Ten projekt jest udostępniony na licencji MIT.
