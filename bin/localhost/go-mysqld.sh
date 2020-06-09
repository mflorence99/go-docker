go-mysqld-stop.sh

docker run \
  --name go-mysqld \
  --net dev.net \
  -d \
  -e MYSQL_DATABASE="$MYSQL_DATABASE" \
  -e MYSQL_USER="$MYSQL_USER" \
  -e MYSQL_PASSWORD="$MYSQL_PASSWORD" \
  -e MYSQL_ROOT_PASSWORD="$MYSQL_PASSWORD" \
  -v go-mysqld-data:/var/lib/mysql \
  mysql:5.7
