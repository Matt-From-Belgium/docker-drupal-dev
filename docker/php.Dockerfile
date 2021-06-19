FROM matthiasba/drupal-dev:latest
COPY .docker/drupal-entrypoint.sh /home/root
COPY ./docker/drupal-install.sh /home/root
COPY ./ /var/www/
RUN echo "host=mysql-server">>/etc/mysql/my.cnf
CMD sh /home/root/drupal-entrypoint.sh
