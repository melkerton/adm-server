v0.0.1
======

----------------------
Minimal Viable Product
----------------------

    adm-server-v0.0.1 will provide

    #. a method for mocking Keycloak endpoints,
    #. a method for mocking typical Django Rest Framework endpoints,
    #. the user with control over the entire Http Response Message.

----------------------
Configuration
----------------------

All configuration is controlled by configuration files. System configuration is found in `server.yaml`. Request matching and response is controlled by `endpoints/index.yaml` [#endpoints]_.

Filename: `server.yaml`.

.. code-block:: none

    server: 
        port: Integer (Default 1025)
        host: String (Default '0.0.0.0')

Filename: `endpoints/index.yaml`.

.. code-block::

    - response: String (Required)
        path: String (Default '/')
        method: String (Default Any)
        query: String (Default None)

----------------------
Execution
----------------------

Change to the root of the directory containing `server.yaml` and `endpoints/` and execute 

.. code-block::

    $ adm-server


**MAILDROP**


----------------------
Release Test
----------------------

Request:

.. code-block::

    GET / HTTP/1.1

Response:

.. code-block::

    HTTP


.. toctree::

   notes.rst
   plan.rst
   pseudo-code.rst

**OLD**


**Target Test Cases**

Case 1) Simple response

Request

.. code-block::

    GET /alpha HTTP/1.1
    host: localhost
    
    .


Response


.. code-block::

    HTTP/1.1 200 Ok

    http://localhost/alpha HTTP/1.1


.. [#endpoints] Why not just `endpoints.yaml`?
    
    A future release will support multiple files in nested directories. 

.. [#specific] Only cases directly required for testing either LugBulk or Barter Ledger are being considered.