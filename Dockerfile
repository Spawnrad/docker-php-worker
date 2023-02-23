FROM php:7.4-fpm

RUN apt-get update && apt-get install -y openssl git libxml2-dev zlib1g-dev libicu-dev libzip-dev g++ unzip supervisor

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version

# Set timezone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime && echo Europe/Paris > /etc/timezone
RUN "date"

# Install the available extensions
# Sockets is for AMQP RabitMQ?
# SOAP validation VAT Number
RUN docker-php-ext-install pdo_mysql intl opcache sockets soap zip

RUN usermod -u 1000 www-data 

# Supervisor
RUN mkdir -p /var/log/supervisor

WORKDIR /var/www/html
