Pseudo Code
===========


#. Client asks Server for a Response.
#. Server asks Sources for an Endpoint.
#. Server asks Endpoint for a Response
#. Server asks Response to write data to Client.

Http response for unmatched request:

.. code-block::

    HTTP/1.1 452 No Match Found
    x-requested-uri: REQUESTED_URI\n\n

References

#. https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
#. https://developer.mozilla.org/en-US/docs/Web/HTTP/Messages