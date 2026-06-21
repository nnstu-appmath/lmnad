# External project - Captured Waves DB

База данных захваченных волн (длинных захваченных волн), разработана Иван Савело.
Разработка в репозиториях:

- lmnad_back - https://github.com/q1000treadz/lmnad_back - backend
- lmnad_front - https://github.com/q1000treadz/lmnad_front - frontend

## Запуск проекта - Captured Waves DB:

В директории: `external_projects/captured_waves_db`
1. Создать .env
```
PORT=8088

DB_HOST=lmnad_db
DB_PORT=3306
DB_DATABASE=lmnad_data
DB_USERNAME=root
DB_PASSWORD=vanya
```

2. Запуск проекта
```
docker-compose up -d
```
Проверить запуск контейнеров

3. Проверить http://localhost:8001/

## Добавить данные

1. Скопировать .env файл в контейнер backend
```
docker cp .env captured_waves_db-capwave_back-1:/app/
```

2. Запустить seed внутри контейнера:
```
docker exec -ti captured_waves_db-capwave_back-1 bash

npm run seed
```

## Для интеграции с LMNAD

Создание БД и пользователя в mysql lmnad:
```
CREATE DATABASE captured_waves_db;
CREATE USER 'user_name'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON captured_waves_db.* TO 'captured_wave_test'@'%';
FLUSH PRIVILEGES;
```
