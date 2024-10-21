- set admin password for portainer in compose.yml: 
[source](`https://gist.github.com/deviantony/62c009b41bde5e078b1a7de9f11f5e55)

- docker compose install gitlab-runner: [source](https://gitlab.com/TyIsI/gitlab-runner-docker-compose/-/blob/main/docker-compose.yml?ref_type=heads)

- Проверка доступности порта  
`nc -zv <ip> 22`

- Не проверять known_hosts и не писать туда:  
`ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null <user>@<ip>`

- Default Proxy Manager username: `admin@example.com`. Default Proxy Manager password: `changeme`.