FROM php:7.4-apache

LABEL maintainer="Coordenadoria de Tecnologia da Informação da Controladoria Geral do Estado do Amapá (CTEC/CGEAP)"

WORKDIR /var/www/html

RUN echo "Instalando dependências do php"
RUN apt-get update
RUN apt-get install -y vim g++ libicu-dev libpq-dev libzip-dev zip zlib1g-dev curl \
            libfreetype6-dev libjpeg62-turbo-dev libpng-dev
RUN docker-php-ext-install bcmath fileinfo intl json mysqli opcache
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd