FROM matthiasba/php-devbox:latest
COPY ./docker/drupal-entrypoint.sh /home/root
COPY ./docker/drupal-install.sh /home/root
RUN rm -rf /var/www/html
RUN ln -s /var/www/web /var/www/html
RUN echo "host=mysql-server">>/etc/mysql/my.cnf
CMD sh /home/root/drupal-entrypoint.sh
