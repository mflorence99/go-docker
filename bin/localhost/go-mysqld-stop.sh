docker exec \
  -it \
  go-mysqld \
  sh -c '/etc/init.d/mysql stop'

docker rm -f go-mysqld
