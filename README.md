1) Создаем папку docker в которую клонируем этот репозиторий
2) В папке docker создаем .env файл по аналогии с .env.example
3) На одном уровне с папкой docker создаем папку с таким же названием, как PROJECT_NAME из .env файла, куда клонируем репозиторий CMS
4) Заходим в папку docker и выполняем `./start.sh`

Смотрим в браузер http://localhost:16000