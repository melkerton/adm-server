v0.0.1
======

----------------------
Minimal Viable Product
----------------------

    adm-server-v0.0.1 will provide

    #. a method for mocking Keycloak and typical Django Rest Framework endpoints,
    #. a basic request matching utility that 
    
        #. performs matches on the requested uri including the query string, for example given the request **http://localhost/widgets?id=1** the match string is **widgets?id=1**,
        #. uses simple comparison matching, i.e. matches exactly the first N characters of each string (where N is the length of the configured path), to determine if there is a match or not.
    #. the user with control over the entire Http Response Message.

----------------------
Configuration
----------------------

All configuration is controlled by configuration files. 

    #. System configuration is found in `server.yaml`. 
    #. Request matching and response is controlled by `endpoints/index.yaml` [#endpoints]_.

Filename: `server.yaml` (YamlMap).

.. code-block:: none

    server: 
        port: Integer (Default 1025)
        host: String (Default '0.0.0.0')

Filename: `endpoints/index.yaml` (YamlList).

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



---------------
System Overview
---------------

This section generally describes the interaction between primary objects.

+++++++++++++++
Primary Objects
+++++++++++++++

#. Server: creates a socket and listens for requests.
#. Sources: file system management.
#. Endpoint: pattern matching and routing.
#. ResponseWriter: http response to client.

+++++++++
Data Flow
+++++++++

#. Client asks Server for a Response.
#. Server asks Sources for an Endpoint.
#. Server asks Endpoint for a Response
#. Server asks Response to write data to Client.

Http response for unmatched request:

.. code-block::

    HTTP/1.1 452 No Match Found
    x-requested-uri: REQUESTED_URI\n\n


----------------------
Release Tests 
----------------------

#. A matched response (200 Ok).

#. An unmatched response (454 No Match).


----------------------
References
----------------------

#. https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
#. https://developer.mozilla.org/en-US/docs/Web/HTTP/Messages


.. [#endpoints] Why not just `endpoints.yaml`?
    
    A future release will support multiple files in nested directories. 

