etc:
	mkdir -p etc
	sudo chown 10001:10001 -R etc

.PHONY: init
init: etc
	docker-compose run horizon -i

.PHONY: start
start:
	docker-compose up -d