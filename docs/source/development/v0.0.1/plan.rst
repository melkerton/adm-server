Plan
====

-------------
Configuration
-------------

All configuration is controlled by configuration files. System configuration is found in `server.yaml`. Request matching and response is controlled by `endpoints/index.yaml` [#endpoints]_.

Filename: `server.yaml`.

.. code-block:: none

    server: 
        port: Integer ? 1025
        host: String ? '0.0.0.0'

Filename: `endpoints/index.yaml`.

.. code-block::

    - endpoint: String
        path: String ? '/'
        method: String ? 'ANY'
        query: String ? NONE
2    .
    .
    .

---------
Execution
---------

Change to the root of the directory containing `server.yaml` and `endpoints` and execute 

.. code-block::

    $ xdm-serve


---------------
System Overview
---------------

This section generally describes the interaction between primary objects.

++++++++++++++++++++++++
Primary Objects | Actors
++++++++++++++++++++++++

#. Server
#. Sources
#. Response Writers

    #. DataResponseWriter
    #. PipeResponseWriter


---------------------------
Communication Flow | Script
---------------------------

See pseudo-code.rst for updated flow.


PlantUml flow diagram

#. Client :math:`\to` Server
#. Server :math:`\to` Sources
#. Sources :math:`\to` Server
#. Server :math:`\to` ResponseWriter
#. ResponseWriter :math:`\to` Server
#. Server :math:`\to` Client

.. [#endpoints] Why not just `endpoints.yaml`?
    
    A future release will support multiple files in nested directories. 