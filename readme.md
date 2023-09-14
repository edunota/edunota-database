# Database migration repository


This repository contains all Database management for edunota tools like migrations, backupbs, ..etc

## Before you start
go installed on your machine
```bash
# use homebrew
brew install go
```

```bash
# use snapd
sudo snap install go --classic 
```

```powershell
# use chocolately
# open administrator powershell
choco install golang
```

install goose module 

```bash
go install github.com/pressly/goose/v3/cmd/goose@latest
```
For a lite version of the binary without DB connection dependent commands, use the exclusive build tags:
```bash
go build -tags='no_mysql no_sqlite3' -o goose ./cmd/goose
```

we use makefile to run scripts. follow [tutorials here](https://linuxhint.com/run-makefile-windows/)

use makefile.dev to spin up dev enviroment

### create 
creates new migration file under /migrations dir
```bash
make -f *.<env> create name=<name_of_the_migration>

# for example migrate on dev enviroment
# make -f *.dev create name=name_of_the_migration
# for production
# make -f *.prod create name=name_of_the_migration
```
it will create file under ./migration name contains name_of_the_migration 
to update submodules run command

### up
migrate to most recent version of database
```bash
make -f *.<env> up
```


### up-by-one 
Migrate the DB up by 1 version
```bash
make -f *.<env> up-by-one  
```

### up-to
Migrate untill spesific version
```bash
make -f *.<env> up-to ver=<ver>

# for example
# make -f *.<env> up-to ver=20170506082420
# if migration successfull will be printout
# OK    20170506082420_create_table.sql
``` 

### down 
Roll back the version by 1

```bash
make -f *.<env> down
```

### down-to ver
```bash
make -f *.<env> down-to ver=<ver>
# for example
#make -f *.dev down-to ver=20170506082527
# OK    20170506082527_alter_column.sql
```

### redo
Roll back the most recently applied migration, then run it again.
```bash
make -f *.<env> redo
# for example
# make -f *.env redo  
# OK    003_and_again.sql
# OK    003_and_again.sql
```
### status
Print the status of all migrations
```bash
make -f *.<env> status

# for example 
#
# make -f *.dev status
#
#   Applied At                  Migration
#   =======================================
#   Sun Jan  6 11:25:03 2013 -- 001_basics.sql
#   Sun Jan  6 11:25:03 2013 -- 002_next.sql
#   Pending                  -- 003_and_again.sql
```
### version
Print the current version of the database:

```bash
make -f *.<env> version

# goose version
# goose: version 002
```

# Annotations

##  -- +goose Up and  -- +goose Down
Each migration file must have exactly one -- +goose Up annotation. The -- +goose Down annotation is optional. If the file has both annotations, then the -- +goose Up annotation must come first.

```sql
-- +goose Up
CREATE TABLE post (
    id int NOT NULL,
    title text,
    body text,
    PRIMARY KEY(id)
);

-- +goose Down
DROP TABLE post;
```
## -- +goose NO TRANSACTION
By default, all migrations are run within a transaction. Some statements like CREATE DATABASE, however, cannot be run within a transaction. You may optionally add -- +goose NO TRANSACTION to the top of your migration file in order to skip transactions within that specific migration file. Both Up and Down migrations within this file will be run

## -- +goose StatementBegin & -- +goose StatementEnd

By default, SQL statements are delimited by semicolons - in fact, query statements must end with a semicolon to be properly recognized by goose.

More complex statements (PL/pgSQL) that have semicolons within them must be annotated with -- +goose StatementBegin and -- +goose StatementEnd to be properly recognized. For example:

-- +goose Up
```sql
-- +goose Up
-- +goose StatementBegin
CREATE OR REPLACE FUNCTION histories_partition_creation( DATE, DATE )
returns void AS $$
DECLARE
  create_query text;
BEGIN
  FOR create_query IN SELECT
      'CREATE TABLE IF NOT EXISTS histories_'
      || TO_CHAR( d, 'YYYY_MM' )
      || ' ( CHECK( created_at >= timestamp '''
      || TO_CHAR( d, 'YYYY-MM-DD 00:00:00' )
      || ''' AND created_at < timestamp '''
      || TO_CHAR( d + INTERVAL '1 month', 'YYYY-MM-DD 00:00:00' )
      || ''' ) ) inherits ( histories );'
    FROM generate_series( $1, $2, '1 month' ) AS d
  LOOP
    EXECUTE create_query;
  END LOOP;  -- LOOP END
END;         -- FUNCTION END
$$
language plpgsql;
-- +goose StatementEnd
```
## submodules
    - infrastructure
all infastructure related resources like docker files placed here, please do not push commits on submodules instead open pr on infastructure repository

to pull changes on submodule
```bash
git submodule update --remote --merge
```
___

## Current database schema
![image](resources/database_digram.png)

you can see interactive diagram [here](https://dbdiagram.io/d/6502197c02bd1c4a5e865426)

