#!/usr/bin/env bash

PROJECT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
pushd "${PROJECT_PATH}"

echo -e "Launching presto dockerization...."
docker-compose down --volumes
find "${PROJECT_PATH}/mysql" ! -name '.gitignore' -delete
sleep 5     # Wait for docker synchronization
make
docker-compose up -d
sleep 60   # Wait for mysql server start
docker-compose exec -ti mysql /bin/bash -c "mysql -uroot -proot -e \"CREATE DATABASE if not exists hive\""
docker-compose exec -ti hive-server /bin/bash -c "/opt/hive/bin/schematool -dbType mysql -initSchema"
docker-compose up -d hive-metastore
sleep 30   # Wait for docker container restart
popd
echo -e "[DONE]"
