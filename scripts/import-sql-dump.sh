#!/usr/bin/env bash

set -e

cd "$(dirname "$0")/../"

SENTRY_INSTALL_FOLDER=/srv/sentry
SENTRY_FOLDER="${SENTRY_INSTALL_FOLDER}/onpremise"

echo "Please run this script before 'install.sh' from ${SENTRY_FOLDER}/sentry!"

if test -f "${SENTRY_FOLDER}/install/create-docker-volumes.sh"; then
    # shellcheck disable=SC1091
    source "${SENTRY_FOLDER}/install/create-docker-volumes.sh"
fi

(
    cd ${SENTRY_FOLDER}
    docker-compose stop
    docker-compose up -d postgres
    docker-compose up wait_postgres
)

cp scripts/dump/dump.sql "$(docker volume inspect sentry-postgres | jq -r .[0].Mountpoint)/"

(
    cd ${SENTRY_FOLDER}
    docker-compose exec postgres bash -c "dropdb -U postgres postgres; createdb -U postgres postgres"
    docker-compose exec postgres psql -U postgres postgres -f /var/lib/postgresql/data/dump.sql
    # In case you need to perform SQL command before launching migration uncomment next line
    # docker-compose exec postgres psql -U "postgres" -d "postgres" -c "YOUR REQUEST HERE"
)
