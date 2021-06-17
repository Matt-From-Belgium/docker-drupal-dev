FROM matthiasba/drupal-dev:latest
COPY ./ /var/www/
CMD sh /home/root/drupal.sh
