app:
	crystal src/main.cr
migrate:
	crystal src/Tasks/migrate_model.cr
admin:
	crystal src/Tasks/generate_admin.cr
test:
	crystal src/Tasks/add_testdata.cr
drop:
	crystal src/Tasks/drop_table.cr
build:
	crystal build --release src/main.cr
main:
	./main
all: migrate test admin app

.PHONY: migrate all
