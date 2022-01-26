FILE_DIR=$(dirname "$0")
cd $FILE_DIR

docker stack deploy -c=docker-compose.traefik.yml --with-registry-auth loadbalancer
