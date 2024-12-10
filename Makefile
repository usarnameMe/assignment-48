# Variables
IMAGE_NAME ?= recipe
CONTAINER_NAME ?= recipe_container
PORT ?= 8000
VENV = .venv
PYTHON = $(VENV)/bin/python3
MANAGE = $(PYTHON) manage.py

# Default target
.PHONY: help
help:
	@echo "Usage:"
	@echo "  make install         Install all dependencies (local)"
	@echo "  make run             Run the development server (local)"
	@echo "  make build           Build Docker image"
	@echo "  make docker-run      Run Docker container"
	@echo "  make shell           Access Django shell inside container"
	@echo "  make makemigrations  Create migrations inside container"
	@echo "  make migrate         Apply migrations inside container"
	@echo "  make createsuperuser Create a superuser inside container"
	@echo "  make populate_db     Populate database using script inside container"
	@echo "  make stop            Stop the running container"
	@echo "  make clean           Remove stopped container"

# Install dependencies (local)
.PHONY: install
install:
	$(VENV)/bin/pip install -r requirements.txt

# Run the development server (local)
.PHONY: run
run:
	$(MANAGE) runserver

# Docker: Build the image
.PHONY: build
build:
	docker build -t $(IMAGE_NAME) .

# Docker: Run the container
.PHONY: docker-run
docker-run:
	docker run -p 127.0.0.1:$(PORT):$(PORT) --name $(CONTAINER_NAME) $(IMAGE_NAME)

# Docker: Access Django shell inside the container
.PHONY: shell
shell:
	docker exec -it $(CONTAINER_NAME) django-admin shell

# Docker: Create migrations inside the container
.PHONY: makemigrations
makemigrations:
	docker exec -it $(CONTAINER_NAME) python manage.py makemigrations

# Docker: Apply migrations inside the container
.PHONY: migrate
migrate:
	docker exec -it $(CONTAINER_NAME) python manage.py migrate

# Docker: Create a superuser inside the container
.PHONY: createsuperuser
createsuperuser:
	docker exec -it $(CONTAINER_NAME) python manage.py createsuperuser

# Docker: Populate the database using a script inside the container
.PHONY: populate_db
populate_db:
	docker exec -it $(CONTAINER_NAME) python manage.py runscript populate_database

# Docker: Stop the running container
.PHONY: stop
stop:
	docker stop $(CONTAINER_NAME)

# Docker: Remove the stopped container
.PHONY: clean
clean:
	docker rm $(CONTAINER_NAME)
