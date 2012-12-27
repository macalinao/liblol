REPORTER = spec

all: build test

build:
	toaster -cd

server:
	cd build; python3 -m http.server

test:
	@./node_modules/mocha/bin/mocha \
		--reporter $(REPORTER) \
		test/*.coffee

.PHONY: all build server test
