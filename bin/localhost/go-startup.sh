go-cleanup.sh

function autostart() {
  running=$(docker inspect --format='{{ .State.Running }}' $1 2> /dev/null)
  if [ "$running" != "true" ]; then
    echo "Autostarting Docker container $1"
    $1.sh
  else
    echo "Docker container $1 already running"
  fi
}

echo "$DOCKER_PASSWORD" | docker login --username "$DOCKER_USERNAME" --password-stdin

if docker network ls | grep "dev\.net" | grep -q "bridge"; then
  echo "Docker network already exists"
else
  docker network create -d bridge dev.net
fi

autostart go-mysqld
