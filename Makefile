default:
	docker run --rm -v ~/.local/haxelib/:/haxelib -v ${PWD}:/app -w /app haxe:4.0-alpine haxe build.hxml

dev:
	npm run dev

run:
	npm start

setup_haxe_lib:
	mkdir ~/.local/haxelib
	haxelib setup ~/.local/haxelib

deps:
	docker run --rm -v ~/.local/haxelib/:/haxelib -v ${PWD}:/app -w /app haxe:4.0-alpine haxelib install build.hxml
	# or just haxelib install build.hxml

http_client:


.PHONY: docker setup_haxe_lib deps
