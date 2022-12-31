v0.0.1
======

.. toctree::
   :maxdepth: 1

   notes.rst
   plan.rst
   pseudo-code.rst

----------------------
Minimal Viable Product
----------------------

The objective of v0.0.1 is to provide a means to test Keycloak endpoints. As such the only Writers that will be implemented is the DefaultResponseWriter and the PipeResponseWriter. 


**Functional Requirements**

    - match requests on

        - path + query, regex or exact

    - support any common case response

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

