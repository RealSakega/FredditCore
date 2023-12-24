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
	npm start
	
stop:
	screen -X -S anonventbot quit

full-start: lock install start
