#!/usr/bin/env bash

set -e

cd "$(dirname "$0")/../"

SENTRY_INSTALL_FOLDER=/srv/sentry
SENTRY_FOLDER="${SENTRY_INSTALL_FOLDER}/onpremise"

if test -f "${SENTRY_FOLDER}/docker-compose.yml"; then
    (
        cd ${SENTRY_FOLDER}
        docker-compose down --remove-orphans
    )
fi

# shellcheck disable=SC2046
docker volume rm $(docker volume ls -f 'name=sentry' -q)

rm -rf ${SENTRY_FOLDER}