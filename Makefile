# testing 
test:
	dart test

test-watch:
	nodemon -x 'dart test' -e 'dart'

# specific tests
test-adms-watch:
	nodemon -x 'dart run' -e 'dart'

# test by test(NAME, () {})
test-N:
	nodemon -x "dart test -N $(N)" -e 'dart'

docs-serve:
	dtach -n docs-serve.d node docs-serve.js

run:
	dart run bin/adm_server.dart test/data/_valid

# publishing


analyze:
	dart analyze .

compile:
	dart compile exe bin/adm_server.dart

coverage:
	rm -rf coverage
	dart run coverage:test_with_coverage
	genhtml coverage/lcov.info -o coverage/html

doc:
	dart doc -o doc/annik

pana:
	pana --no-warning .

.PHONY: coverage doc test