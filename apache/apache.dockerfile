# Author : Luke Park

FROM php:7.4-apache

ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONUNBUFFERED=1
ARG CERT_DIR
ARG SERVICE

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install -y vim && \
    rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo pdo_mysql

COPY apache/${CERT_DIR}/${SERVICE}.key /etc/ssl/private/${SERVICE}.key
COPY apache/${CERT_DIR}/${SERVICE}.crt /etc/ssl/${CERT_DIR}/${SERVICE}.crt
COPY apache/web/site.conf /etc/apache2/sites-available/site.conf

RUN a2enmod ssl && \
    a2enmod rewrite && \
    a2dissite 000-default default-ssl && \
    a2ensite site