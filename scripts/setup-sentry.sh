#!/usr/bin/env bash

set -e


cd "$(dirname "$0")/../"

SENTRY_INSTALL_FOLDER=/srv/sentry
SENTRY_VERSION=21.4.1

mkdir -p "${SENTRY_INSTALL_FOLDER}"

if ! [[ $(find "${SENTRY_INSTALL_FOLDER}/onpremise" -maxdepth 1) ]]; then
    git clone https://github.com/getsentry/onpremise.git "${SENTRY_INSTALL_FOLDER}/onpremise"
    cp scripts/files/docker-compose.override.yml onpremise/docker-compose.override.yml
fi

(
    cd "${SENTRY_INSTALL_FOLDER}/onpremise"
    git checkout "${SENTRY_VERSION}"
    ./install.sh --no-user-prompt
    docker-compose up -d
)