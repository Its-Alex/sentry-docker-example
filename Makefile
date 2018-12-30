.PHONY: up
	docker-compose run --rm sentry sentry upgrade --noinput
	docker-compose up -d redis postgres
	docker-compose -f docker-compose-tools.yml run --rm wait_postgres
	docker-compose -f docker-compose-tools.yml run --rm wait_redis
	docker-compose run --rm sentry sentry createuser \
		--email admin@example.com \
		--password password \
		--superuser --no-input
	docker-compose up -d

.PHONY: clean
clean:
	docker-compose down -v --remove-orphans
	rm -rf postgresql-data/