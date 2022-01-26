FILE_DIR=$(dirname "$0")
cd $FILE_DIR

sudo mkdir -p /docker-volumes/letsencrypt

docker network create -d overlay traefik-public
docker swarm init
docker stack deploy -c=docker-compose.traefik.yml --with-registry-auth loadbalancer
