default:
	docker run --rm -v ~/.local/haxelib/:/haxelib -v ${PWD}:/app -w /app haxe:4.0-alpine haxe build.hxml

dev/server:
	npm run dev

dev/client:
	~/.gopath/bin/watcher -cmd 'make' -keepalive src/

run:
	npm start

setup_haxe_lib:
	mkdir ~/.local/haxelib
	haxelib setup ~/.local/haxelib

deps:
	docker run --rm -v ~/.local/haxelib/:/haxelib -v ${PWD}:/app -w /app haxe:4.0-alpine haxelib install --always build.hxml
	npm i
	# or just haxelib install build.hxml

.PHONY: setup_haxe_lib deps dev default
