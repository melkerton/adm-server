# testing 
test:
	dart test
	
test-watch:
	nodemon -x 'dart test' -e 'dart'

docs-serve:
	dtach -n docs-serve.d node docs-serve.js

# publishing

analyze:
	dart analyze .

compile:
	dart compile

coverage:
	rm -rf coverage
	dart run coverage:test_with_coverage
	codecov -t ba3ac644-3887-4b26-8733-1c9df8db6fa9

doc:
	dart doc -o doc/annik

pana:
	pana --no-warning .

.PHONY: coverage doc test