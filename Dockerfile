FROM php:8.2-apache

# 1. Install Dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    wget \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli fileinfo zip \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/*

# 2. Set Workdir
WORKDIR /var/www/html

# 3. Add Entrypoint Script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# 4. Entrypoint
ENTRYPOINT ["entrypoint.sh"]
CMD ["apache2-foreground"]