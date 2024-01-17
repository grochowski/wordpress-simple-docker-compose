#!/usr/bin/env bash
show_message () {
    printf "\033[0;35m*** $@\033[0m\n"
}

# run containers
show_message "Running Wordpress..."
docker-compose up -d

# wait for all wordpress files to appear
while [ ! -e ./wp_data/wp-config.php ]; do
  printf '.'
  sleep 5
done

# read all .env variables
source .env set

# create db
show_message "Creating DB..."
./wp.sh db create

# installing core
show_message "Installing core..."
./wp.sh core install --url=$WP_APP_HOST --title="$WP_APP_NAME" --admin_user=$WP_INIT_ADMIN_USERNAME --admin_password=$WP_INIT_ADMIN_PASSWORD --admin_email=$WP_INIT_ADMIN_EMAIL --locale=$WP_INIT_LOCALE

# update core
show_message "Updating core, themes and plugins..."
./wp.sh core update
./wp.sh core update-db
./wp.sh plugin update --all
./wp.sh theme update --all

# theme install
show_message "Installing theme: $WP_INIT_THEME_SINGLE"
./wp.sh theme install $WP_INIT_THEME_SINGLE --activate

# plugins install
show_message "Installing plugins: $WP_INIT_PLUGIN_LIST"
./wp.sh plugin install $WP_INIT_PLUGIN_LIST --activate


show_message "Finished. Visit your website at http://$WP_APP_HOST:$WP_APP_PORT"
