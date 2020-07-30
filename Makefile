# NOTE: $@ = make target
#				$^ = all dependencies
#				$< = leftmost dependency

# NOTE: Makefile uses sh, instead of bash

# NOTE: $(name) is reserved for Makefile vars, use $$(name) for command execution (or backticks)



# rails port on host and inside container
railsPort = 3000

# live reload (used for HTML) port on host and inside container
# BUG: server crashes when using a different port
livereloadPort = 35729

# webpacker Dev Server (used for CSS/JS) port on host and inside container
# BUG: does not (yet) work on different port
webpackerPort = 3035

# location of node_modules folder, keep outside docker bind mount
nodeModulesPath = /node_modules

# PostgreSQL user
# NOTE: changes only take effect in fresh postgres container (e.g. reset volumes!)
postgresUser = rails

# randomly generated PostgreSQL password
# TODO: secure random generator
# NOTE: changes only take effect in fresh postgres container (e.g. reset volumes!)
# postgresPassword = $$(date +%s | sha256sum | base64 | head -c 77)
postgresPassword = YTE4ZjNiMmIxNzAxYTJjMjc1YTYwOWM4YWI3ZGU4ZTIzZWQxMjM2YWJhZTEyOWJmOGFlZGRkNDA5



# DEFAULT COMMAND
.PHONY: default
default:
	@ echo "Check './Makefile' to see what commands are available..."



# GENERATE FILES

# generate .env file with current user:group
.PHONY: .env
.env:
	@ printf "\
# This file is maintained by 'make .env', please do not edit\n\
# It contains environment variables that are used in docker-compose.yml itself\n\
# Other environment variables are configured in docker-compose.yml\n\
\n\
HOST_UID=%d\n\
HOST_GID=%d\n\
\n\
RAILS_PORT=%d\n\
LIVERELOAD_PORT=%d\n\
WEBPACKER_PORT=%d\n\
\n\
NODE_MODULES_PATH=%b\n\
\n\
POSTGRES_USER=%b\n\
POSTGRES_PASSWORD=%b\n\
	" $$(id -u) $$(id -g) \
	  $(railsPort) $(livereloadPort) $(webpackerPort) \
		$(nodeModulesPath) \
		$(postgresUser) $(postgresPassword) > "./.env"



# Reset db
.PHONY: reset-db
reset-db:
	@ bash ./.bin/reset_db.sh



# SHORTCUTS
# simplify startup
.PHONY: up down
up:
	@ docker-compose up -d
down:
	@ docker-compose down
restart:
	@ docker-compose restart



# build containers
build: .env
	@ docker-compose build
rebuild: .env
	@ docker-compose build --no-cache



# open bash in server/db service, regardless if they are running or not
.PHONY: _bash-% server db
_bash-%: # use exec when the server is up, otherwise use run
	@ if [ $$(make -s _$*-up?) = "1" ]; then \
			echo 'Entering Docker... (exec)'; \
			docker-compose exec $* bash; \
		else \
			echo 'Entering Docker... (run)'; \
			docker-compose run $* bash; \
		fi

server: _bash-server # NOTE: wildcards do not have autocompletion, hence lines like this
db: _bash-db # autocomplete



# check if server and/or db are running
.PHONY: _%-up? server-up? db-up? up?
_%-up?:
	@ if [ -z `docker-compose ps -q $*` ] \
				|| [ -z `docker ps -q --no-trunc | grep \`docker-compose ps -q $*\`` ]; then \
			echo "0"; \
		else \
			echo "1"; \
		fi

up?:
	@ printf "server up?\t%b\n" $$(make -s server-up?)
	@ printf "db up?\t\t%b\n"		$$(make -s db-up?)

.PHONY: server-up?
server-up?:
	@ if [ $$(make -s _server-up?) = "1" ]; then echo "Yes"; else echo "No"; fi

.PHONY: db-up?
db-up?:
	@ if [ $$(make -s _db-up?) = "1" ]; then echo "Yes"; else echo "No"; fi




.PHONY: adminer
adminer:
	@ docker build -f .docker/adminer.dockerfile -t ee5-adminer:latest  .docker/adminer/
	@ docker run \
			-p 8080:8080 \
		 	--name ee5-adminer \
			--network ee5_default \
			--rm \
			--env-file .env \
			-e ADMINER_PLUGINS='auto-login' \
			ee5-adminer:latest
