# Use official PHP image with Apache
FROM php:8.2-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git unzip curl libzip-dev zip libonig-dev libxml2-dev libpq-dev \
    && docker-php-ext-install pdo pdo_mysql zip

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy project files
COPY . .

# Set Apache to use Laravel public directory
ENV APACHE_DOCUMENT_ROOT /var/www/html/public

RUN sed -ri -e 's!/var/www/html!/var/www/html/public!g' /etc/apache2/sites-available/000-default.conf

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Laravel setup commands
RUN php artisan key:generate \
 && php artisan migrate --force \
 && php artisan storage:link

# Set permissions
RUN chown -R www-data:www-data storage bootstrap/cache

# Expose HTTP port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
