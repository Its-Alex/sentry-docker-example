# Sentry docker-compose example

This is a comprehensive [Sentry](https://sentry.io/welcome/) installation based on one `docker-compose.yml` file.

Sentry version support: [9.0.0](https://github.com/getsentry/sentry/releases/tag/9.0.0)

Comprehensive means that the `docker-compose.yml` contains all Sentry dependencies to work:

- PostgreSQL
- Redis
- Postfix

You can start and configure Sentry with:

```
$ make up
```

You can now go on the interface create a new project at [http://localhost:9000](http://localhost:9000)

Default login are:

* username: user@example.com
* password: password

And clean it with:

```
$ make clean
```
