#!/bin/bash

# Определение имён контейнеров
CONTAINERS="ubuntu centos7 fedora1"

# Запуск контейнеров
docker run -d --name ubuntu ubuntu:latest tail -f /dev/null
docker run -d --name centos7 centos:7 tail -f /dev/null
docker run -d --name fedora1 fedora:latest tail -f /dev/null

echo "Контейнеры запущены. Выполнение Ansible Playbook..."
# Пауза для удостоверения, что контейнеры полностью запущены
sleep 5

# Запуск Ansible Playbook
ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass

# Остановка и удаление контейнеров
echo "Остановка и удаление контейнеров..."
for CONTAINER in $CONTAINERS; do
    docker stop $CONTAINER
    docker rm $CONTAINER
done

# Добавление изменений в Git
echo "Добавление изменений в Git..."
git add .
git commit -m "Automated run of containers and ansible playbook"
git push

echo "Скрипт завершен."
