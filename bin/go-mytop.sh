docker run \
  --net dev.net \
  --rm \
  -e MYSQL_DATABASE="$MYSQL_DATABASE" \
  -e MYSQL_HOST="$MYSQL_HOST" \
  -e MYSQL_PORT="$MYSQL_PORT" \
  -e MYSQL_USER="$MYSQL_USER" \
  -e MYSQL_PASSWORD="$MYSQL_PASSWORD" \
  -it \
  srcoder/mytop \
  mytop -h $MYSQL_HOST -P $MYSQL_PORT -u $MYSQL_USER -p $MYSQL_PASSWORD -d $MYSQL_DATABASE -s 5
