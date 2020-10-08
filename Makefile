.DEFAULT_GOAL := help

define HELP_INFO
Available commands:

DOCKER MANAGEMENT
run                 Run all containers
run-backend-db      Run the backend and database containers only
rebuild             Rebuild all containers from scratch

GLOBAL
fmt                 Run code auto-formatters
test                Run tests

FRONTEND
frontend-shell      Run a Unix shell in the frontend container

BACKEND
backend-iex         Run an IEx shell in the backend container
backend-shell       Run a Unix shell in the backend container
backend-routes      List the API endpoints on the backend

DATABASE
db-setup            Create, migrate, and seed the database
db-shell            Run a postgres shell in the database container

(Note that most commands require the containers to be running.)
endef

BACKEND_CONTAINER = nfl-rushing-backend
DB_CONTAINER = nfl-rushing-db
FRONTEND_CONTAINER = nfl-rushing-frontend

BACKEND_EXEC = docker-compose exec ${BACKEND_CONTAINER}
BACKEND_RUN = docker-compose run ${BACKEND_CONTAINER}
DB_EXEC = docker-compose exec ${DB_CONTAINER}
DB_RUN = docker-compose run ${DB_CONTAINER}
FRONTEND_EXEC = docker-compose exec ${FRONTEND_CONTAINER}
FRONTEND_RUN = docker-compose run ${FRONTEND_CONTAINER}

help:
	@: $(info $(HELP_INFO))

#### Docker management

run:
	docker-compose up

# This is useful since the Vue dev server, unfortunately, clobbers output
run-backend-db:
	docker-compose up ${BACKEND_CONTAINER} ${DB_CONTAINER}

rebuild:
	docker-compose down -v --remove-orphans
	docker-compose build

#### Global

fmt:
	${FRONTEND_RUN} npm run lint
	${BACKEND_RUN} mix format

test:
	${BACKEND_EXEC} sh -c "MIX_ENV=test mix test"

#### Frontend

frontend-shell:
	${FRONTEND_EXEC} sh

#### Backend

backend-iex:
	${BACKEND_RUN} iex -S mix

backend-shell:
	${BACKEND_EXEC} sh

backend-routes:
	${BACKEND_RUN} mix phx.routes

#### Database

db-setup:
	${BACKEND_EXEC} mix ecto.create
	${BACKEND_EXEC} mix ecto.migrate
	${BACKEND_EXEC} mix run priv/repo/seeds.exs

db-shell:
	${DB_EXEC} psql -U postgres nfl_rushing
