-----------------
Notes
-----------------

Need to complete Keycloak testing for Barter Ledger.

- the request is immutable and defined by the requesting client
- matching on every thing is not required

    - method yes
    - version no
    - headers no
    - path yes
    - query partially
    - body no

for v0.0.1 only support matching on method and path + query as a whole

required features

- ability to return jwt token with valid expiration date

potential features

- regex on path matching