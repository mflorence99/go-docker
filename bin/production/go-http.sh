# docker pull $DOCKER_USERNAME/go-http

docker rm -f go-http

docker run \
  --log-opt max-size=10m \
  --log-opt max-file=1 \
  --name=go-http \
  -d \
  -e HTTP_CONFIG="$HTTP_CONFIG" \
  -e HTTP_HOST="$HTTP_HOST" \
  -e HTTP_PORT="$HTTP_PORT" \
  -e HTTP_SECRET="$HTTP_SECRET" \
  -e MYSQL_DATABASE="$MYSQL_DATABASE" \
  -e MYSQL_HOST="$MYSQL_HOST" \
  -e MYSQL_PORT="$MYSQL_PORT" \
  -e MYSQL_USER="$MYSQL_USER" \
  -e MYSQL_PASSWORD="$MYSQL_PASSWORD" \
  -p 5000:5000 \
  $DOCKER_USERNAME/go-http

  docker logs -f go-http
