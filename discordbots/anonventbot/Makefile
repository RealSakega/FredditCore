include ../../.config/.env-anonventbot
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
	
stop:
	screen -X -S website quit

full-start: lock install start
