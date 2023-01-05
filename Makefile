# testing 
test:
	dart test

test-watch:
	nodemon -x 'dart test' -e 'dart'

# specific tests
test-adms-watch:
	nodemon -x 'dart run' -e 'dart'


test-endpoint-watch:
	nodemon -x 'dart test test/endpoint_test.dart' -e 'dart'

test-example-watch:
	cd example && nodemon -x 'dart run ../bin/adm_server.dart' -w '../' -e 'dart'


test-pipe-response-watch:
	nodemon -x 'dart test test/pipe_response_writer_test.dart' -e 'dart'

test-server-watch:
	nodemon -x 'dart test test/server_test.dart' -e 'dart'

test-sherpa-watch:
	nodemon -x 'dart test test/sherpa_test.dart' -e 'dart'

test-sources-watch:
	nodemon -x 'dart test test/sources_test.dart' -e 'dart'

# 
docs-serve:
	dtach -n docs-serve.d node docs-serve.js

# publishing

analyze:
	dart analyze .

compile:
	dart compile exe bin/adm_server.dart

coverage:
	rm -rf coverage
	dart run coverage:test_with_coverage

coverage-local: coverage
	genhtml coverage/lcov.info -o coverage/html

coverage-remote: coverage
	codecov -t ba3ac644-3887-4b26-8733-1c9df8db6fa9

doc:
	dart doc -o doc/annik

pana:
	pana --no-warning .

.PHONY: coverage doc test