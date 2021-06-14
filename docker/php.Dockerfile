FROM matthiasba/drupal-dev:latest
COPY ./ /var/www/
RUN sh /home/root/drupal.sh
#CMD ["apache2-foreground"]
CMD /bin/bash
