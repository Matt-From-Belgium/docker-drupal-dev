#!/bin/bash
a2enmod rewrite
cd /var/www
ln -s /var/www/web /var/www/html
php -d memory_limit=-1 /usr/local/bin/composer install
chown -R root:www-data /var/www/web/sites
chmod -R 775 /var/www/web/sites
echo "alias drush='/var/www/vendor/drush/drush/drush'" >> /home/root/.bashrc
echo "alias drupal='/var/www/vendor/drupal/console/bin/drupal'" >> /home/root/.bashrc
wait-for-it --host=mysql-server --port=3306 --timeout=30
./vendor/drush/drush/drush -y si minimal --root=/var/www/web --db-url=mysql://root:secret@mysql-server/drupal --config-dir=/var/www/config --account-pass=admin
./vendor/drush/drush/drush -y cr
chown -R root:www-data /var/www/web/sites
chown -R root:www-data /var/www/web/modules
chown -R root:www-data /var/www/web/themes
chmod -R 775 /var/www
chmod 775 ./web/sites/default/settings.php
echo "\$settings['config_sync_directory'] = '../config';" >> ./web/sites/default/settings.php
echo "\$settings['file_private_path'] = '';"  >> ./web/sites/default/settings.php
echo "\$settings['file_temp_path'] = '/tmp';" >> ./web/sites/default/settings.php
echo "\$settings['trusted_host_patterns'] = [" >> ./web/sites/default/settings.php
echo "  '^localhost\$'," >> ./web/sites/default/settings.php
echo "];" >> ./web/sites/default/settings.php
chmod 755 ./web/sites/default
chmod 755 ./web/sites/default/settings.php
mkdir private
chmod 770 ./private
./vendor/drush/drush/drush cron
apache2-foreground
