## DEVELOPMENT

Project uses
Ruby version: 3.1.0
Rails: 7.0.3
VSCode Extensions: Ruby, Ruby solargraph, Rubocop

## DATABASE

![Database diagram](images/table_relation.png)

## RUN LOCALLY

Prerequisite: Docker

Run the project with `docker compose up` command.

**If you running the project first time you need to run following commands while `docker compose up` running**
- `docker compose run web rails db:create` to create databases
- `docker compose run web rails db:migrate` to run migration
- `docker compose run web rails db:seed` to fill database with seed data

### RUN TESTS

To run tests run `docker compose run web rails spec`

### RUN CUSTOM COMMANDS

To run rails command `docker compose run web rails [command]`.

Ex: `docker compose run web rails c` to open console or `docker compose run web rails routes` to print routes etc..

## DEPLOY


