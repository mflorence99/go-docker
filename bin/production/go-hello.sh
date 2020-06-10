# docker pull $DOCKER_USERNAME/go-hello

# @see https://stackoverflow.com/questions/24319662
# --network="host" only necessary as we are simulating a production 
# environment with HTTP_HOST=localhost in production/go-settings.sh

docker run \
  --log-opt max-size=10m \
  --log-opt max-file=1 \
  --name=go-hello \
  --network="host" \
  --rm \
  -e HELLO_CONFIG="$HELLO_CONFIG" \
  -e HELLO_SECRET="$HELLO_SECRET" \
  -e HTTP_HOST="$HTTP_HOST" \
  -e HTTP_PORT="$HTTP_PORT" \
  -it \
  $DOCKER_USERNAME/go-hello

