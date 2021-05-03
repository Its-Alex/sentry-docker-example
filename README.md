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

## Get started

First you must start VM and play with scripts:

```
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
# cd /scripts/
```