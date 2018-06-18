.PHONY: create-docker-sentry-network
create-docker-sentry-network:
	docker network create sentry 2>>/dev/null || true

.PHONY: up
up: create-docker-sentry-network
	docker-compose up -d sentry_redis sentry_postgres
	docker-compose run --rm wait_sentry_postgres
	docker-compose run --rm wait_sentry_redis
	docker run --rm -it --network=sentry \
		-e SENTRY_REDIS_HOST=sentry_redis \
		-e SENTRY_POSTGRES_HOST=sentry_postgres \
		-e SENTRY_DB_USER=sentry \
		-e SENTRY_DB_PASSWORD=sentry \
		-e SENTRY_SECRET_KEY="%**stxva=es(qsts1z1eu!1uks3r9q8z@w8dh8hm&akv3p9a*s" \
		sentry:9 sentry upgrade --noinput
	docker run --rm -it --network=sentry \
		-e SENTRY_REDIS_HOST=sentry_redis \
		-e SENTRY_POSTGRES_HOST=sentry_postgres \
		-e SENTRY_DB_USER=sentry \
		-e SENTRY_DB_PASSWORD=sentry \
		-e SENTRY_SECRET_KEY="%**stxva=es(qsts1z1eu!1uks3r9q8z@w8dh8hm&akv3p9a*s" \
		sentry:9 sentry createuser \
		--email user@example.com \
		--password password \
		--superuser --no-input
	docker-compose up -d

.PHONY: clean
clean:
	docker network rm sentry 2>>/dev/null || true
	docker-compose down -v --remove-orphans
	rm -rf postgresql-data/