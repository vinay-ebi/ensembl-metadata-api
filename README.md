# ensembl-metadata-api


Create Virtual environment with pyenv
```bash

pyenv install 3.8.3

pyenv virtualenv 3.8.3 ensembl_metadata_api

pyenv activate ensembl_metadata_api
```

To run the project clone and install dependencies:

```bash

git clone  https://github.com/vinay-ebi/ensembl-metadata-api

cd ensembl-metadata-api

pip install -r requirements.txt

pip install . 

python -m ensembl.production.metadata_api.app.main
```

This will start the server on the configured host.

You can find swagger documentation at `/api/docs`.


## Docker

You can start the project with docker using this command:

```bash
docker-compose -f deploy/docker-compose.yml --project-directory . up --build
```

If you want to develop in docker with autoreload add `-f deploy/docker-compose.dev.yml` to your docker command.
Like this:

```bash
docker-compose -f deploy/docker-compose.yml -f deploy/docker-compose.dev.yml --project-directory . up
```

This command exposes the web application on port 8000, mounts current directory and enables autoreload.

But you have to rebuild image every time you modify requirements.txt with this command:

```bash
docker-compose -f deploy/docker-compose.yml --project-directory . build
```

## Project structure

```bash
ensembl-metadata-api
src
├── ensembl
│   └── production
│       └── metadata_api
│           ├── app
│           │   ├── api # Package with all handlers.
│           │   ├── __init__.py
│           │   ├── main.py #Startup script. Starts uvicorn.
│           │   └── settings.py # Main configuration settings for project.
│           ├── database # module contains db configurations
│           │   ├── db_startupevent_lifetime.py
│           │   ├── dependencies.py
│           │   └── utils.py
│           ├── __init__.py
│           ├── metadataManager #metadata db ORM modules
│           │   ├── base.py
│           │   ├── __init__.py
│           │   ├── meta.py
│           │   └── models 
│           ├── migrations # scripts to initialize/upgrade metadata database
│           │   ├── env.py
│           │   ├── __init__.py
│           │   ├── script.py #migration script 
│           │   └── versions
│           └── static # Static content.
│               └── docs
└── tests
    ├── conftest.py # Fixtures for all tests.
    ├── __init__.py
    └── test_ensembl-metadata-api.py
```

## Configuration

This application can be configured with environment variables.

You can create `.env` file in the root directory and place all
environment variables here. 

All environment variabels should start with "ENSEMBL-METADATA-API_" prefix.

For example if you see in your "ensembl-metadata-api/settings.py" a variable named like
`random_parameter`, you should provide the "ENSEMBL-METADATA-API_RANDOM_PARAMETER" 
variable to configure the value. This behaviour can be changed by overriding `env_prefix` property
in `ensembl-metadata-api.settings.Settings.Config`.

An exmaple of .env file:
```bash
ENSEMBL-METADATA-API_RELOAD="True"
ENSEMBL-METADATA-API_PORT="8000"
ENSEMBL-METADATA-API_ENVIRONMENT="dev"
```

You can read more about BaseSettings class here: https://pydantic-docs.helpmanual.io/usage/settings/

## Pre-commit

To install pre-commit simply run inside the shell:
```bash
pre-commit install
```

pre-commit is very useful to check your code before publishing it.
It's configured using .pre-commit-config.yaml file.

By default it runs:
* black (formats your code);
* mypy (validates types);
* isort (sorts imports in all files);
* flake8 (spots possibe bugs);
* yesqa (removes useless `# noqa` comments).


You can read more about pre-commit here: https://pre-commit.com/

## Kubernetes
To run your app in kubernetes
just run:
```bash
kubectl apply -f deploy/kube
```

It will create needed components.

If you haven't pushed to docker registry yet, you can build image locally.

```bash
docker-compose -f deploy/docker-compose.yml --project-directory . build
docker save --output ensembl-metadata-api.tar ensembl-metadata-api:latest
```

## Migrations

If you want to migrate your database, you should run following commands:
```bash
# To run all migrations untill the migration with revision_id.
alembic upgrade "<revision_id>"

# To perform all pending migrations.
alembic upgrade "head"
```

### Reverting migrations

If you want to revert migrations, you should run:
```bash
# revert all migrations up to: revision_id.
alembic downgrade <revision_id>

# Revert everything.
 alembic downgrade base
```

### Migration generation

To generate migrations you should run:
```bash
# For automatic change detection.
alembic revision --autogenerate

# For empty file generation.
alembic revision
```


## Running tests

If you want to run it in docker, simply run:

```bash
docker-compose -f deploy/docker-compose.yml --project-directory . run --rm api pytest -vv .
docker-compose -f deploy/docker-compose.yml --project-directory . down
```

For running tests on your local machine.
1. you need to start a database.

I prefer doing it with docker:
```
docker run -p "3306:3306" -e "MYSQL_PASSWORD=ensembl-metadata-api" -e "MYSQL_USER=ensembl-metadata-api" -e "MYSQL_DATABASE=ensembl-metadata-api" -e ALLOW_EMPTY_PASSWORD=yes bitnami/mysql:8.0.28
```


2. Run the pytest.
```bash
pytest -vv .
```
