#!/usr/bin/env bash

set -e

cd "$(dirname "$0")/../"

SENTRY_INSTALL_FOLDER=/srv/sentry
SENTRY_FOLDER="${SENTRY_INSTALL_FOLDER}/onpremise"

cp scripts/files/extract_dsn.py "${SENTRY_FOLDER}/"

(
    cd "${SENTRY_FOLDER}"
    docker cp ./extract_dsn.py "$(docker-compose ps web | tail -n1 | cut -d' ' -f1):/extract_dsn.py"
    docker-compose exec -T web sentry exec /extract_dsn.py | tail -n1
    rm extract_dsn.py
)
