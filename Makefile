default:
	docker run --rm -v ~/.local/haxelib/:/haxelib -v ${PWD}:/app -w /app haxe:4.0-alpine haxe build.hxml

docker:
	docker build -t theremix/the-gauntlet:latest .

dev-server:
	npm run dev

dev-client:
	~/.gopath/bin/watcher -cmd 'make' -keepalive src/

run:
	npm start

setup_haxe_lib:
	mkdir ~/.local/haxelib
	haxelib setup ~/.local/haxelib

deps:
	parallel ::: 'docker run --rm -v ~/.local/haxelib/:/haxelib -v ${PWD}:/app -w /app haxe:4.0-alpine haxelib install --always build.hxml' 'npm i'
	@# or just haxelib install build.hxml

.PHONY: default dev-server dev-client run setup_haxe_lib deps
