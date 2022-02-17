build:
	docker build --rm \
	-t local/getting-started \
	-t local/getting-started:1 \
	.

DB_PW=my-super-pw
DB_DB=my_db
DB_USER=my_db-user
DB_HOST=my-db

run_mysql:
	docker run \
	--name ${DB_HOST} \
	-e MYSQL_ROOT_PASSWORD=${DB_PW} \
	-e MYSQL_DATABASE=${DB_DB} \
	-e MYSQL_PASSWORD=${DB_PW} \
	-e MYSQL_USER=${DB_USER} \
	-d \
	-p 3306:3306 \
	mysql:5.7.37;

run_service:
	docker run \
	--link=${DB_HOST} \
	-p 3000:3000 \
	-e MYSQL_DB=${DB_DB} \
	-e MYSQL_PASSWORD=${DB_PW} \
	-e MYSQL_USER=${DB_USER} \
	-e MYSQL_HOST=${DB_HOST} \
	local/getting-started:1;

stop:
	docker stop ${DB_HOST}
	docker rm ${DB_HOST}

rm_service:
	docker rm -f $$(docker container ls -q --all --filter "label=tp.docker.workshop")
