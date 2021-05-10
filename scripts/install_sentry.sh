#!/usr/bin/env bash

set -e

cd "$(dirname "$0")/../"

SENTRY_INSTALL_FOLDER=/srv/sentry
SENTRY_FOLDER="${SENTRY_INSTALL_FOLDER}/onpremise"

(
    cd "${SENTRY_FOLDER}"
    ./install.sh --no-user-prompt
    docker-compose up -d
)