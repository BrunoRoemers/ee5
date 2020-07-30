#!/usr/bin/env bash

# root at <current file>/../..
ROOT_PATH=$(dirname $(dirname $(readlink -f $0)))

# name of root folder (e.g. appended to docker compose volumes)
ROOT_NAME=$(basename $ROOT_PATH)

# docker compose volume name for db
DC_DB_VOLUME="${ROOT_NAME}_ee5-postgres"



# SHUT DOWN SERVER AND DB
if [ $(make -s _server-up?) = "1" ] || [ $(make -s _db-up?) = "1" ]; then
  echo -e "* Shutting down...\n"
  docker-compose down
fi



# DELETE DOCKER VOLUME
if [ $(docker volume ls | grep -o -m 1 $DC_DB_VOLUME) = "$DC_DB_VOLUME" ]; then
  echo -e "\n* Deleting Docker volume ${DC_DB_VOLUME}...\n"
  printf "Volume %b deleted!\n" $(docker volume rm $DC_DB_VOLUME)
fi



# RAILS DB:CREATE
echo -e "\n* Creating Rails Database...\n"
docker-compose run server rails db:create



# RAILS DB:MIGRATE
echo -e "\n* Running Rails Database Migrations...\n"
docker-compose run server rails db:migrate
