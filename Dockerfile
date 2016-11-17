FROM eboraas/apache-php

MAINTAINER "Lmaky <lmaky88@gmail.com">

COPY apache_default /etc/apache2/sites-available/000-default.conf

RUN /usr/sbin/a2enmod rewrite

RUN apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://www.adminer.org/static/download/4.2.5/adminer-4.2.5-mysql.php \
  && mkdir -p /var/www/html/adminer \
  && mv adminer-4.2.5-mysql.php /var/www/html/adminer/index.php
