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
```
$ goose status
$   Applied At                  Migration
$   =======================================
$   Sun Jan  6 11:25:03 2013 -- 001_basics.sql
$   Sun Jan  6 11:25:03 2013 -- 002_next.sql
$   Pending                  -- 003_and_again.go
```

## submodules
    - infrastructure
all infastructure related resources placed here, please do not push commits on submodules instead open pr on infastructure repository


```bash
git submodule update --remote --merge
```
___

## Current database schema
![image](resources/database_digram.png)

you can see interactive diagram [here](https://dbdiagram.io/d/6502197c02bd1c4a5e865426)

