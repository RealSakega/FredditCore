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
	screen -r website -X stuff "^C"

full-start: lock install start
