# Use the official PHP image with Apache
FROM php:8.2-apache

# Install required PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Enable Apache rewrite module
RUN a2enmod rewrite

# Copy all files to the container
COPY . /var/www/html/

# Set proper permissions for the web server
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html \
    && chmod -R 777 /var/www/html/users.json \
    && chmod -R 777 /var/www/html/error.log

# Expose port 80
EXPOSE 80