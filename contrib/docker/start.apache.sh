#!/bin/bash

# Create the storage tree if needed and fix permissions
cp -r storage.skel/* storage/
chown -R www-data:www-data storage/ bootstrap/

php artisan migrate

# Refresh the environment
php artisan storage:link
php artisan horizon:publish
php artisan route:cache
php artisan view:cache
php artisan config:cache

# Finally run Apache
apache2-foreground
