.PHONY: dev/server
dev/server:
	docker-compose -f docker-compose.yml up

.PHONY: dev/client
dev/client:
	cd client && yarn start

.PHONY: build/client
build/client:
	cd client && yarn build

.PHONY: client/install
client/install:
	cd client && yarn install
