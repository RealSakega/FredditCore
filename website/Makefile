export

.PHONY: test start lock

test:
	env

lock:
	npm i --package-lock-only

install:
	npm ci

start:
	screen -S website -d -m npm start
	
stop:
	screen -X -S website quit

full-start: lock install start
