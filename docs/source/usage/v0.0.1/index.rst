v0.0.1-alpha
============

Notes: 

    #. this is for `linux-amd64` only. Other OS support is untested. 
    #. this user documentation has not yet been reviewed for consistency.

Quickstart
----------


.. code-block::

    curl https://github.com/melkerton/adm-server/releases/download/v0.0.1-alpha/adms-v0.0.1-alpha-linux-amd64.exe
    chmod +x adms-v0.0.1-alpha-linux-amd64.exe
    ./adms-v0.0.1-alpha-linux-amd64.exe

This will download and run `adms-*.exe` in the current directory. The will create a server that listens on `localhost` on a random open port (> 1024).

Alternatively pass a directory path as the first (and only) argument to `adms-*exe` to use a specifc directory for response data (note this approach has not been fully tested).

Configuration
-------------


Server
++++++

Allows specifying port and host. Format:

.. code-block::

    # File: `adms.yaml`
    server:
        port: Integer
        host: String

Request to Response Mapping
+++++++++++++++++++++++++++

Maps http requests to a response. This file is a YamlList of YampMap's that maps the requested resource to a response. Format:

.. code-block::

    # File: `index.yaml`
    - path: String
      response: String
    # ...

#. `path` is a full url including query params, but without the protocol, host, and leading '/'. Matching is case-sensitive and exact.
#. `response` is detailed in the next section.

Response Files
++++++++++++++

A flat file that contains an HttpMessage [#httpmessage]_ or a path to an executable that prints an HttpMessage to stdout. Format:

#. Add an `x-adms-status-code` header field to set the response status code.
#. Any response file prefixed with `pipe` [#pipes]_ is treated as an executable.
#. All others are expected to be a flat file.


Conventions
+++++++++++

#. `adms-*exe` 
#. A `response data` directory is the root for response data and can contain `adms.yaml`, and `index.yaml`.
#. `File:` is a response data directory relative path.
#. `adms.yaml`.server.host expects a host string without the protocol. i.e. `localhost` and not `http://localhost`

Version Dependencies
++++++++++++++++++++

TODO

Examples
--------

Flat file response with status code:

.. code-block::

    x-adms-status-code: 201

    {"id": 1}

Flat file response with only a body:

.. code-block::

    {"id": 1}

Executable response using python:

.. code-block::

    #!/usr/bin/env python3
    import sys
    import json

    print("x-adms-status-code: 200\n")

    object = {
        'response': sys.argv[0],
        'requested-uri': sys.argv[1]
    }

    print(json.dumps(object))

.. [#httpmessage] `Http Messages <https://developer.mozilla.org/en-US/docs/Web/HTTP/Messages>`_, without a `start line`.

.. [#pipes] Not really a pipe, i.e. nothing is passed to stdin, however a future release will the adopt this behavior.