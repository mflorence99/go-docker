docker volume ls -qf dangling=true | grep -v sw-* | xargs docker volume rm
docker rm -v $(docker ps -a -q -f status=exited)
docker rmi $(docker images -f "dangling=true" -q)
echo --- ; docker volume ls
echo --- ; docker ps -a
echo --- ; docker images

