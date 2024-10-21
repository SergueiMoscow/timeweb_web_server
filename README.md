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

