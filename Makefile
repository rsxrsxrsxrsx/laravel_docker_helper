up:
	docker compose up -d

down:
	docker compose down

down-all:
	docker stop $(docker ps -a -q)

delete-all:
	docker rm $(docker ps -a -q)

cli:
	docker compose exec php-cli sh

cli-0:
	docker exec -u 0 php-cli sh