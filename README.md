Как запустить проект Xcode с GitHub
Xcode: Убедитесь, что Xcode установлен на вашем Mac (скачайте из App Store или с сайта Apple Developer).
Git: Установите Git, если он еще не установлен (brew install git через Homebrew или скачайте с git-scm.com).

Шаги
1. Клонирование репозитория

Перейдите на страницу репозитория на GitHub.
Нажмите зеленую кнопку Code и скопируйте URL репозитория (HTTPS или SSH).
Откройте терминал и выполните:git clone git@github.com:2whitewolf/Quiz.git

2.  Открытие проекта в Xcode

Найдите в папке проекта файл с расширением .xcodeproj


Дважды щелкните по файлу, чтобы открыть его в Xcode,


3. Установка зависимостей

Swift Package Manager:
Если проект использует Swift Package Manager, Xcode автоматически загрузит зависимости.
Для обновления пакетов в Xcode выберите File > Swift Packages > Update to Latest Package Versions.



4. Настройка проекта

В Xcode выберите целевую платформу (например, iOS Simulator или подключенное устройство).
Убедитесь, что выбрана правильная схема (Scheme) в верхнем левом углу интерфейса Xcode.
Проверьте настройки Signing & Capabilities (Target > Signing & Capabilities):
Выберите вашу Team и убедитесь, что установлен действующий сертификат подписи, если вы запускаете приложение на физическом устройстве.
Для симулятора или личного устройства достаточно бесплатной учетной записи Apple Developer.



5. Сборка проекта

Соберите проект, нажав Cmd + B или выбрав Product > Build в меню Xcode.
Если возникают ошибки сборки, проверьте:
Совместимость версии Xcode с требованиями проекта (указано в README).
Совместимость версии Swift (указано в Podfile или настройках проекта).
Наличие всех необходимых зависимостей.



6. Запуск проекта

Нажмите Cmd + R или кнопку Run (треугольник) в Xcode.
Выберите симулятор или подключенное устройство iOS для запуска.
Для запуска на физическом устройстве убедитесь, что устройство зарегистрировано в учетной записи Apple Developer и настроено для разработки.





![Simulator Screenshot - iPhone 16 Pro - 2025-06-05 at 00 22 27](https://github.com/user-attachments/assets/14b2cb02-4094-42a8-bb6f-f338b9b86e91)
![Simulator Screenshot - iPhone 16 Pro - 2025-06-05 at 00 22 41](https://github.com/user-attachments/assets/ef69829d-b6d0-4b74-8edf-bbbed0e730da)
![Simulator Screenshot - iPhone 16 Pro - 2025-06-05 at 00 22 51](https://github.com/user-attachments/assets/2ce56123-d7b4-4774-bd3b-44a506495e1f)
![Simulator Screenshot - iPhone 16 Pro - 2025-06-05 at 00 23 15](https://github.com/user-attachments/assets/b5452468-1466-4fcd-bfd2-6c859b3d1400)
![Simulator Screenshot - iPhone 16 Pro - 2025-06-05 at 00 23 34](https://github.com/user-attachments/assets/1dcd6522-c1ed-4f8e-873d-771e1a6a4b65)
All questions and results are stored on Fiebase Database
<img width="1031" alt="Screenshot 2025-06-05 at 00 27 04" src="https://github.com/user-attachments/assets/2ba3a7e9-e8d1-4d53-a2bc-70033acacbe5" />
