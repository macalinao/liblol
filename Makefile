REPORTER = spec

build:
	toaster -cd

server:
	cd build; python3 -m http.server

test:
	@./node_modules/mocha/bin/mocha \
		--reporter $(REPORTER) \
		test/*.coffee

.PHONY: build server test
