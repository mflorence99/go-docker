running=$(docker inspect --format='{{ .State.Running }}' go-dev 2> /dev/null)

if [ "$running" != "true" ]; then

  docker rm -f go-dev

  docker run \
    --dns 8.8.8.8 \
    --name go-dev \
    --net dev.net \
    -e DOCKER_EMAIL="$DOCKER_EMAIL" \
    -e DOCKER_PASSWORD="$DOCKER_PASSWORD" \
    -e DOCKER_USERNAME="$DOCKER_USERNAME" \
    -e HELLO_CONFIG="$HELLO_CONFIG" \
    -e HELLO_SECRET="$HELLO_SECRET" \
    -e HTTP_CONFIG="$HTTP_CONFIG" \
    -e HTTP_SECRET="$HTTP_SECRET" \
    -e MYSQL_DATABASE="$MYSQL_DATABASE" \
    -e MYSQL_HOST="$MYSQL_HOST" \
    -e MYSQL_PORT="$MYSQL_PORT" \
    -e MYSQL_USER="$MYSQL_USER" \
    -e MYSQL_PASSWORD="$MYSQL_PASSWORD" \
    -h localhost \
    -it \
    -p 5000:5000 \
    -v $HOME/.ssh:/root/.ssh-orig \
    -v $HOME/.gitconfig:/root/.gitconfig \
    -v $DEV_DIR:/go-dev \
    -v /var/run/docker.sock:/var/run/docker.sock \
    $DOCKER_USERNAME/go-dev \
    bash
  
else

  docker exec -it go-dev bash

fi
