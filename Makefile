.PHONY: up
	docker-compose up -d sentry_redis sentry_postgres
	docker-compose run --rm wait_sentry_postgres
	docker-compose run --rm wait_sentry_redis
	docker-compose run --rm sentry sentry upgrade --noinput
	docker-compose run --rm sentry sentry createuser \
		--email user@example.com \
		--password password \
		--superuser --no-input
	docker-compose up -d

.PHONY: clean
clean:
	docker-compose down -v --remove-orphans
	rm -rf postgresql-data/