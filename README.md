# Sentry playground

This playground use `vagrant` and `virtualbox` to run and play with a sentry
deployed on a VM.

## Requirement

- `asdf`
- `virtualbox`

We use `asdf` to install dependencies:

```
$ asdf plugin-add vagrant https://github.com/asdf-community/asdf-hashicorp.git
$ asdf install
```

Some plugins are required with vagrant:

```
$ vagrant plugin install vagrant-hostmanager --plugin-version 1.8.9
```

- [Sentry playground](#sentry-playground)
  - [Requirement](#requirement)
  - [Get started](#get-started)
  - [Scripts](#scripts)
    - [Setup / Destroy](#setup--destroy)
    - [Create user](#create-user)
    - [Import postgres dump](#import-postgres-dump)

## Get started

First you must start VM and play with scripts:

```
$ mkdir -p "${PWD}/sentry-onpremise"
$ vagrant up
Bringing machine 'sentry' up with 'virtualbox' provider...
==> sentry: Importing base box 'ubuntu/bionic64'...
==> sentry: Matching MAC address for NAT networking...
==> sentry: Checking if box 'ubuntu/bionic64' version '20210415.0.0' is up to date...
==> sentry: Setting the name of the VM: sentry-docker-example_sentry_1620037991329_84550
==> sentry: Clearing any previously set network interfaces...
==> sentry: Preparing network interfaces based on configuration...
    sentry: Adapter 1: nat
    sentry: Adapter 2: hostonly
==> sentry: Forwarding ports...
    sentry: 22 (guest) => 2222 (host) (adapter 1)
==> sentry: Running 'pre-boot' VM customizations...
==> sentry: Booting VM...
==> sentry: Waiting for machine to boot. This may take a few minutes...
    sentry: SSH address: 127.0.0.1:2222
    sentry: SSH username: vagrant
    sentry: SSH auth method: private key
...
$ vagrant ssh
$ sudo su
```

Then you can go setup and install sentry:

```
# cd /srv/sentry/scripts/
# ./setup_sentry.sh
# ./install_sentry.sh
▶ Parsing command line ...

▶ Setting up error handling ...

▶ Checking minimum requirements ...
...
Creating sentry_onpremise_snuba-cleanup_1                            ... done
Starting sentry_onpremise_snuba-replacer_1                           ... done
Creating sentry_onpremise_snuba-transactions-cleanup_1               ... done
Starting sentry_onpremise_snuba-sessions-consumer_1                  ... done
Starting sentry_onpremise_snuba-subscription-consumer-events_1       ... done
Creating sentry_onpremise_relay_1                                    ... done
Starting sentry_onpremise_snuba-transactions-consumer_1              ... done
Starting sentry_onpremise_snuba-outcomes-consumer_1                  ... done
Starting sentry_onpremise_snuba-api_1                                ... done
Creating sentry_onpremise_ingest-consumer_1                          ... done
Creating sentry_onpremise_post-process-forwarder_1                   ... done
Creating sentry_onpremise_web_1                                      ... done
Creating sentry_onpremise_subscription-consumer-events_1             ... done
Creating sentry_onpremise_cron_1                                     ... done
Creating sentry_onpremise_worker_1                                   ... done
Creating sentry_onpremise_sentry-cleanup_1                           ... done
Creating sentry_onpremise_subscription-consumer-transactions_1       ... done
Creating sentry_onpremise_nginx_1                                    ... done
```

Sentry is ready to accept connection on http://local.sentry.fr.

## Scripts

All following scripts must be launch in VM from `/srv/sentry/scripts`.

### Setup / Destroy

There is two different script two different scripts to install sentry:

- [`setup_sentry.sh`](/scripts/setup_sentry.sh) is to initialize sentry git
  and dependencies
- [`install_sentry.sh`](/scripts/install_sentry.sh) simply launch the sentry
  `install.sh` script and then launch containers

You can clean all sentry installation with `down.sh`

### Create user

You can create an admin user with [`create-user.sh`](/scripts/create-user.sh):

- Username: `admin@example.com`
- Password: `password`

### Import postgres dump

You can import a dump from another sentry postgres database. It's recommended
to do it **before** installing sentry.

You must place and rename your dump in `/scripts/dump/dump.sql`.

Then connect to VM and launch [`import-sql-dump.sh`](/scripts/import-sql-dump.sh).
