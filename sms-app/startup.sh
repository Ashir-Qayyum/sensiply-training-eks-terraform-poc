#!/bin/sh
set -e

export SPRING_DATASOURCE_PASSWORD=$(cat /run/secrets/mysql_password)

exec java -jar app.jar