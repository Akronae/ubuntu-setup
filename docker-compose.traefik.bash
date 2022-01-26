FILE_DIR=$(dirname "$0")
cd $FILE_DIR

docker network create -d overlay traefik-public
docker swarm init
docker stack deploy -c=docker-compose.traefik.yml --with-registry-auth loadbalancer
