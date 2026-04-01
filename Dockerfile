FROM php:8.4-cli

# Dependencias del sistema
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl \
    libzip-dev \
    zip \
    libssl-dev \
    pkg-config \
    libcurl4-openssl-dev

# Extensiones PHP necesarias
RUN docker-php-ext-install pdo pdo_mysql zip

# Instalar MongoDB extension
RUN pecl install mongodb \
    && docker-php-ext-enable mongodb

# Instalar Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /app

COPY . .

# Instalar dependencias ignorando platform req (por seguridad en build)
RUN composer install --no-dev --optimize-autoloader --ignore-platform-reqs

EXPOSE 8000

CMD php artisan serve --host=0.0.0.0 --port=8000