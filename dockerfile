# Use official PHP image with Apache
FROM php:8.2-apache

# Set working directory
WORKDIR /var/www/html

# Install required extensions
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libzip-dev \
    && docker-php-ext-install zip

# Enable Apache modules
RUN a2enmod rewrite headers

# Copy only essential files
COPY index.php users.json error.log .htaccess ./

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html && \
    chmod 666 users.json error.log

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
    CMD curl -f http://localhost/ || exit 1

EXPOSE 80