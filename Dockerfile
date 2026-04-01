FROM php:8.4-cli

# Dependencias del sistema (IMPORTANTE añadir autoconf, gcc, make)
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl \
    libzip-dev \
    zip \
    libssl-dev \
    pkg-config \
    libcurl4-openssl-dev \
    libonig-dev \
    libxml2-dev \
    autoconf \
    g++ \
    make

# Extensiones PHP
RUN docker-php-ext-install pdo pdo_mysql zip

# MongoDB extension (con build tools disponibles)
RUN pecl install mongodb \
    && docker-php-ext-enable mongodb

# Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /app

COPY . .

# Instalar dependencias
RUN composer install --no-dev --optimize-autoloader --ignore-platform-reqs

EXPOSE 8000

CMD php artisan serve --host=0.0.0.0 --port=8000