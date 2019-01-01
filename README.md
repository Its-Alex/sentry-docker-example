# Sentry docker-compose example

This is a comprehensive [Sentry](https://sentry.io/welcome/) installation based on one `docker-compose.yml` file.

Sentry version support: [9.0.0](https://github.com/getsentry/sentry/releases/tag/9.0.0)

Comprehensive means that the `docker-compose.yml` contains all Sentry dependencies to work:

- PostgreSQL
- Redis

You can start and configure Sentry with:

```
$ make up
```

You can now go on the interface create a new project at [http://localhost:9000](http://localhost:9000)

Default login are:

* username: admin@example.com
* password: password

Sometime, you need to extract project DSN to use it in script:

```
$ ./display-sentry-dsn.sh
http://31c372722bba471db79faa5b138319e3:c9ebc1de783c4614b679f899cdf0a3f8@0.0.0.0:9001/1
```

Execute this line to stop and clean Sentry installation:

```
$ make clean
```

# Ansible role

Ansible role has been created based on this repository

* [ansible-role-sentry](https://github.com/harobed/ansible-role-sentry)
* [Ansible Role Sentry usage demonstration repository](https://github.com/harobed/ansible-role-sentry-example)

# Licence

[MIT](https://en.wikipedia.org/wiki/MIT_License)