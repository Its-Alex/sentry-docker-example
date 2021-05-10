#!/usr/bin/env bash

set -e

cd "$(dirname "$0")/../"

(
    cd onpremise
    docker-compose run --rm web sentry createuser \
        --email admin@example.com \
        --password password \
        --superuser \
        --no-input \
        --force-update
)
