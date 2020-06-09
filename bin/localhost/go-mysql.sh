docker run \
  --net dev.net \
  --rm \
  -e MYSQL_DATABASE="$MYSQL_DATABASE" \
  -e MYSQL_HOST="$MYSQL_HOST" \
  -e MYSQL_PORT="$MYSQL_PORT" \
  -e MYSQL_USER="$MYSQL_USER" \
  -e MYSQL_PASSWORD="$MYSQL_PASSWORD" \
  -it \
  mysql:5.7 \
  mysql --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --password=$MYSQL_PASSWORD --database=$MYSQL_DATABASE
