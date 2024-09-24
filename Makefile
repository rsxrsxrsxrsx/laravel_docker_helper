up:
	docker compose up -d

down:
	docker compose down

down-all:
	docker stop $(docker ps -a -q)

delete-all:
	docker rm $(docker ps -a -q)

php:
	docker exec -it app-php bash