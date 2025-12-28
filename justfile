set unstable

PROJECT_NAME := "garage"

GREEN := '\033[0;32m'
YELLOW := '\033[0;33m'
RED := '\033[0;31m'
NC := '\033[0m'

# Detect container engine with compose syntax
CONTAINER_ENGINE_WITH_COMPOSE := \
    if which("docker") != "" { "docker compose" } \
    else if which("podman") != "" { \
        if which("docker-compose") != "" { "docker-compose" } \
        else { "podman compose" } \
    } \
    else { "docker compose" }

COMPOSE_FILE := "-f ./docker-compose.yaml"
COMPOSE_OVERRIDE_FILE := "-f ./docker-compose.override.yaml"

DOCKER_COMPOSE := CONTAINER_ENGINE_WITH_COMPOSE + " -p " + PROJECT_NAME + " " + COMPOSE_FILE

[default]
help:
    @echo "Garage 관리 스크립트"
    @echo ""
    @just --list

build:
    @echo "{{GREEN}}Building all services...{{NC}}"
    @{{DOCKER_COMPOSE}} build
    @echo "{{GREEN}}Services built successfully!{{NC}}"

up:
    @echo "{{GREEN}}Starting all services...{{NC}}"
    @{{DOCKER_COMPOSE}} up -d
    @echo "{{GREEN}}Services started successfully!{{NC}}"

override:
    @echo "{{GREEN}}Starting all services...{{NC}}"
    @{{DOCKER_COMPOSE}} {{COMPOSE_OVERRIDE_FILE}} up -d
    @echo "{{GREEN}}Services started successfully!{{NC}}"

deploy: build override

down:
    @echo "{{YELLOW}}Stopping all services...{{NC}}"
    @{{DOCKER_COMPOSE}} down

logs:
    @echo "{{GREEN}}Showing logs...{{NC}}"
    @{{DOCKER_COMPOSE}} logs -f

status:
    @echo "{{GREEN}}Service status:{{NC}}"
    @{{DOCKER_COMPOSE}} ps

clean-all: clean-images clean-volumes

clean-images:
    @echo "{{RED}}Cleaning up images...{{NC}}"
    @{{DOCKER_COMPOSE}} down --rmi all

clean-volumes:
    @echo "{{RED}}Cleaning up volumes...{{NC}}"
    @{{DOCKER_COMPOSE}} down --volumes
