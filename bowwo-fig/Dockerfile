FROM tutum/apache-php:latest
MAINTAINER bowwow <bowwo@gmail.com>

# Install packages
RUN apt-get update && \
  apt-get -yq install mysql-client && \
  apt-get -y install git && \
  rm -rf /var/lib/apt/lists/*

# Add permalink feature
RUN a2enmod rewrite
ADD wordpress.conf /etc/apache2/sites-enabled/000-default.conf

# Download latest version of Wordpress into /app
RUN rm -fr /app
RUN git clone https://github.com/WordPress/WordPress.git WordPress
ADD WordPress/ /app
RUN ls -la WordPress/
ADD wp-config.php /app/wp-config.php

# Add script to create 'wordpress' DB
ADD run-wordpress.sh /run-wordpress.sh
RUN chmod 755 /*.sh

# Modify permissions to allow plugin upload
RUN chmod -R 777 /app/wp-content

# Expose environment variables
ENV DB_HOST 127.0.0.1
ENV DB_PORT 3306
ENV DB_NAME wordpress
ENV DB_USER admin
ENV DB_PASS 1qaz2wsx..

EXPOSE 80
VOLUME ["/app/wp-content"]
CMD ["/run-wordpress.sh"]
