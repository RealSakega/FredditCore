include ../../.secrets/.env-anonventbot
export

.PHONY: test start lock

test:
	env

lock:
	npm i --package-lock-only

install:
	npm ci

start:
	screen -S anonventbot -d -m npm start

full-start: lock install start
