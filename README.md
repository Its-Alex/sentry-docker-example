# Sentry docker-compose example

This is an docker-compose file to deploy sentry v9

You can launch this sentry with:

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
