FROM php:7.4-apache

RUN echo "Atualizando dependências do sistema"
RUN apt-get update

RUN echo "Instalando dependências do sistema Linux"
RUN apt-get install -y vim g++ libicu-dev libpq-dev libzip-dev zip libbz2-dev zlib1g-dev libldap2-dev curl \
libldb-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev exiftool

RUN echo "Instalando e habilitando extensões do PHP"
RUN docker-php-ext-install bcmath intl mysqli pdo zip bz2
RUN docker-php-ext-configure zip
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd
RUN echo "Habilitando otimizações no OPcache"
RUN docker-php-ext-configure opcache --enable-opcache
RUN docker-php-ext-install opcache
RUN echo "Instalando e habilitando exif"
RUN docker-php-ext-configure exif
RUN docker-php-ext-install exif
RUN docker-php-ext-enable exif
# Enable Apache ldap auth module
RUN echo "Habilitando LDAP"
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/
RUN docker-php-ext-install ldap
# RUN apk update \
#     && apk add --no-cache --virtual .build-dependencies-in-virtual-world openldap-dev \
#     && docker-php-ext-install ldap \
#     && docker-php-ext-enable  ldap \
#     && apk del .build-dependencies-in-virtual-world
# RUN docker-php-ext-enable ldap opcache'

COPY ./docker/apache/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY ./docker/apache/start-apache /usr/local/bin

RUN rm -rf /var/www/html
RUN mkdir /var/www/glpi
WORKDIR /var/www/glpi
COPY ./glpi10 /var/www/glpi/

# CMD [ "php", "./your-script.php" ]