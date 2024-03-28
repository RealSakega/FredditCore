include .env
export

.PHONY: lock
lock:
	npm i --package-lock-only

.PHONY: install
install:
	npm ci

.PHONY: start
start:
	screen -S anonventbot -d -m npm start

.PHONY: stop
stop:
	screen -X -S anonventbot quit

.PHONY: restart
restart: stop start

.PHONY: full-start
full-start: lock install start
