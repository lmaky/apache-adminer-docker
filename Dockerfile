FROM eboraas/apache-php

MAINTAINER "Lmaky <lmaky88@gmail.com">

COPY apache_default /etc/apache2/sites-available/000-default.conf

RUN /usr/sbin/a2enmod rewrite

RUN echo "deb http://deb.debian.org/debian/ oldstable main contrib non-free" >> /etc/apt/sources.list

RUN apt-get update \
  && apt-get install -y curl \
  && apt-get install -y wget \
  && apt-get install -y php5-curl \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://www.adminer.org/static/download/4.2.5/adminer-4.2.5-mysql.php \
  && mkdir -p /var/www/html/adminer \
  && mv adminer-4.2.5-mysql.php /var/www/html/adminer/index.php

RUN sed -i -e 's/upload_max_filesize = 2M/upload_max_filesize = 20M/g' /etc/php5/apache2/php.ini
RUN sed -i -e 's/post_max_size = 8M/post_max_size = 20M/g' /etc/php5/apache2/php.ini

COPY apache2-foreground /usr/local/bin/apache2-foreground

CMD ["apache2-foreground"]
