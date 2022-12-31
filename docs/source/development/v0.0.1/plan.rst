Plan
====

-------------
Configuration
-------------


---------
Execution
---------

Change to the root of the directory containing `server.yaml` and `endpoints/` and execute 

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
