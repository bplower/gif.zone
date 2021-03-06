
# Backend ----------------------------------------------------------------------

.PHONY: backend-build
backend-build:
	cd backend && cargo build

.PHONY: backend-run
backend-run:
	cd backend && cargo run ./config/settings.yml

.PHONY: backend-test
backend-test:
	cd backend && cargo test

# Frontend ---------------------------------------------------------------------

.PHONY: frontend-setup
frontend-setup:
	cd frontend && npm install

.PHONY: frontend-build
frontend-build:
	cd frontend && npm run-script build

.PHONY: frontend-lint
frontend-lint:
	cd frontend && ./node_modules/eslint/bin/eslint.js src

.PHONY: frontend-run
frontend-run:
	cd frontend && serve -s build

.PHONY: frontend-clean
frontend-clean:
	rm -rf frontend/build

# Database --------------------------------------------------------------------

.PHONY: db-start
db-start:
	docker-compose up -d db

.PHONY: db-stop
db-stop:
	docker-compose stop db

.PHONY: db-deploy
db-deploy:
	sqitch deploy db:pg://gif_zone:gif_zone@localhost

.PHONY: db-revert
db-revert:
	sqitch revert -y db:pg://gif_zone:gif_zone@localhost

.PHONY: db-shell
db-shell:
	PGPASSWORD=gif_zone psql -U gif_zone -h localhost gif_zone

# Docker -----------------------------------------------------------------------

.PHONY: backend-docker-build
backend-docker-build:
	docker-compose build backend

.PHONY: backend-docker-run
backend-docker-run:
	docker-compose up backend

.PHONY: frontend-docker-build
frontend-docker-build:
	docker-compose build frontend

.PHONY: frontend-docker-run
frontend-docker-run:
	docker-compose up web

# Local tls certs ---------------------------------------------------------------

.PHONY: gen-keys
gen-keys:
	cd dev_config && ./gen_tls_keys.sh
