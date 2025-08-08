SHELL := /bin/bash

# === Common Python/Django Commands ===

runserver:
	@echo "Starting Django development server..."
	python manage.py runserver

shell:
	@echo "Opening Django shell..."
	python manage.py shell_plus

migrate:
	@echo "Applying database migrations..."
	python manage.py migrate

makemigrations:
	@echo "Creating new migrations..."
	python manage.py makemigrations

createsuperuser:
	@python manage.py createsuperuser

# === Code Quality ===

format:
	@echo "Formatting code with Black and isort..."
	python -m black apps config manage.py
	python -m isort apps config manage.py

lint:
	@echo "Running Ruff linter..."
	ruff check .

# === Testing ===

test:
	@echo "Running tests with pytest..."
	pytest --ds=config.settings.test

# === Cleanups ===

clean-pyc:
	@echo "Removing .pyc files..."
	find . -name "*.pyc" -delete

clean-migrations:
	@echo "Removing old migration files..."
	find . -path "*/migrations/*.py" -not -name "__init__.py" -delete

# === Environment & Secrets ===

secret:
	@echo "Generating new Django SECRET_KEY..."
	@SECRET=$$(python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())") && \
	echo "SECRET_KEY=$$SECRET" >> environments/dev.env && \
	echo "SECRET_KEY=$$SECRET" >> environments/prod.env && \
	echo "✓ SECRET_KEY added to environments/.dev and .prod"


