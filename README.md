# Создание облачного сервера Timeweb

Структура для создания минимальной фиксированной конфигурации (Cloud-15) облачного сервера Timeweb Cloud.  
- ОС **Ubuntu 22.04`**
- CPU **1**
- RAM **1024**
- Публичный IP адрес

Установка:
- `git`
- `docker`
- `portainer`
- `nginx proxy manager`

#### Требования:
- `terraform ~> 1.9.8`
- `ansible >= 2.14.9`
- `vault `

#### Инициализация  
`terraform init`

#### Запуск  
`terraform apply`

После создания сервера запускается ansible для установки дополнительного софта (portainer, nginx), прописанного в [compose.yml](src/ansible/compose.yml)

Если сервер создаётся очень долго, то возможен выход по timeout из ansible, тогда нужно вручную запустить [run_ansible.sh](src/ansible/run_ansible.sh)

#### Проверка:
- portainer: `http://<ip>:9000`
- nginx: `http://<ip>81` Login `admin@example.com`, password `changeme`.

### После отработки `terraform apply`

#### Если произошёл сбой

Если сбой произошёл на этапе ansible, то проверить, есть ли ssh соединение. Очень редко бывает, что сервер создался, но подключения на порт 22 нет. В этом случае лучше сделать `terraform destroy` и заново `terraform apply`.

Если сбой на этапе ansible, можно запустить **предварительно прописав workspace**, `run_ansible.sh`

#### Создать runner в gitlab и на созданном сервере запустить gitlab-runner register:
```
docker run --rm -it \
  -v /srv/gitlab-runner/config:/etc/gitlab-runner \
  gitlab/gitlab-runner:alpine register \
  --non-interactive \
  --url "<CI_SERVER_URL>" \
  --token "<REGISTRATION_TOKEN>" \
  --executor "docker" \
  --description "Tag-Only Runner" \
  --docker-image "docker:dind"
```
#### Заменить в /var/gitlab-runner/config/congig.toml
строку:
```
    volumes = ["/cache"]
```
на
```
    volumes = ["/var/run/docker.sock:/var/run/docker.sock", "/cache"]
```

#### Завершение настройки при необходимости
- Назначить доменное имя
- Подключить сертификат
- Загрузить данные в БД
- Загрузить изображения