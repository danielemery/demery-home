# Demery Home

Simple landing page for https://demery.net

Should provide key links and contact details for Daniel Emery.

## Build

### Doppler

Doppler is using for application configuration and is required for all development environments.

You can connect to your project using:

```sh
doppler login
doppler setup
```

The Makefile will automatically invoke commands with `doppler run` where necessary.

### Makefile

A `Makefile` is provided defining each possible action.

- `make` will run all commands needed to bootstrap the local environment and generate the static site.
- `make install` will install required npm packages
- `make build` will generate the static site
