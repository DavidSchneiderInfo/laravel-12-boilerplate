all: build dep-install node-build up

# Container management
up:
	docker compose up -d

down:
	docker compose down

build:
	docker compose build

# Dependency management
dist: composer-install node-build

dep-install: composer-install node-install

composer-install:
	docker compose run --rm composer
node-install:
	docker compose run --rm node
node-build:
	docker compose run --rm node npm run build

# Setup local dev environment
local/setup:
	mkdir -p storage/logs/nginx
	cat .env.example > .env
	make dep-install
	make node-build
	make up
	docker compose exec -ti php-fpm php artisan key:generate
	docker compose exec -ti php-fpm php artisan migrate --seed

local/purge:
	docker compose down -v
	rm -rf ./node_modules ./vendor .env

local/reset:
	docker compose down -v
	make up

mysql-cli:
	docker compose exec mysql mysql -u root -ppassword -h mysql

# Testing
phpunit: up
	docker compose exec -ti php-fpm php artisan test

