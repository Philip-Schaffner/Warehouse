FROM php:8.3-apache

# Install Microsoft ODBC Driver for SQL Server
RUN apt-get update; \
    apt-get install -y --no-install-recommends \
    gnupg2 \
    unixodbc-dev \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 \
    && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN pecl install sqlsrv pdo_sqlsrv \
    && docker-php-ext-enable sqlsrv pdo_sqlsrv

# Create a directory for the PHP error log
RUN mkdir -p /var/log/php && chown www-data:www-data /var/log/php

EXPOSE 80

# Declare the volume for the PHP error log
VOLUME /var/log/php