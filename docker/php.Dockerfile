FROM matthiasba/drupal-dev:latest
COPY ./ /var/www/
RUN echo "host=mysql-server">>/etc/mysql/my.cnf
CMD sh /home/root/drupal-entrypoint.sh
