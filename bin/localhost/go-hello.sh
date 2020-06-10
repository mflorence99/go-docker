# docker pull $DOCKER_USERNAME/go-hello

docker run \
  --dns 8.8.8.8 \
  --log-opt max-size=10m \
  --log-opt max-file=1 \
  --name=go-hello \
  --net dev.net \
  --rm \
  -e HELLO_CONFIG="$HELLO_CONFIG" \
  -e HELLO_SECRET="$HELLO_SECRET" \
  -e HTTP_HOST="$HTTP_HOST" \
  -e HTTP_PORT="$HTTP_PORT" \
  -h localhost \
  -it \
  $DOCKER_USERNAME/go-hello

