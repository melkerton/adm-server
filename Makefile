# testing 
test:
	dart test
	
test-watch:
	nodemon -x 'dart test' -e 'dart'

# publishing

analyze:
	dart analyze .

compile:
	dart compile

coverage-build:
	test_with_coverage

coverage-format:
	format_coverage -i coverage/coverage.json

coverage-upload:
	codecov -t ba3ac644-3887-4b26-8733-1c9df8db6fa9

doc:
	dart doc -o doc/annik

pana:
	pana --no-warning .

.PHONY: coverage doc test