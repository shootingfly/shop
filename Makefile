## Migrate database and run specs
##   $ make all
## Migrate database only
##   $ make migrate
## Runs specs only
##   $ make spec
app:
	crystal src/main.cr
migrate:
	#mysql -q < sql/001.sql
	crystal src/migrate.cr
insert:
	mysql -q < sql/insert.sql
spec:
	crystal spec
test:
	@mysql -e "use shop; $(shell cat sql/test.sql)"
all: migrate spec app

.PHONY: migrate spec all