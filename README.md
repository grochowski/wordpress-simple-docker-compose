# Wordpress with Docker Compose 🐋

Simple docker-compose configuration for Wordpress made for local development. Contains:
- wordpress container,
- db container (MariaDB),
- wp-cli container,
- PhpMyAdmin container

I am not actively maintaining it. Feel free to fork and modify to your own needs.

## How to start

Requirements: 
- Installed Docker service (up and running!)
- Docker-compose

Steps:
- Create file `.env` with contents based on `env.example`
- Provide your own values for variables in newly created `.env`
- Run `docker-compose up` to run the containers

For first run, run `init.sh` script. It runs quick Wordpress installation with predefined plugins and themes of your choice (configuration is done in `.env` file) using wp-cli.

Your files will be available in `wp-data` directory.

## Available scripts

**wp.sh** - WP-CLI wrapper, that enables a simplified running of wp-cli container. Examples:

```
./wp.sh --info
./wp.sh core update
```

**init.sh** - Init script, to be called for a quick spawn of Wordpress installation with chosen plugins and themes:

```
./init.sh
```

Script uses configuration found in .env file.