#!/usr/bin/env bash

set -e

cd "$(dirname "$0")/../"

SENTRY_INSTALL_FOLDER=/srv/sentry
SENTRY_FOLDER="${SENTRY_INSTALL_FOLDER}/onpremise"
SENTRY_VERSION=21.4.1

mkdir -p "${SENTRY_INSTALL_FOLDER}"

if ! [[ $(find "${SENTRY_FOLDER}" -maxdepth 1) ]]; then
    git clone https://github.com/getsentry/onpremise.git "${SENTRY_FOLDER}"
fi

cp scripts/files/docker-compose.override.yml onpremise/docker-compose.override.yml

(
    cd "${SENTRY_FOLDER}"
    git checkout "${SENTRY_VERSION}"
)