#!/usr/bin/env python3
import sys
import json

# consume stdin
data = "".join(sys.stdin.readlines())

http_message = "HTTP/1.1 200 Ok\n\nPipeBeta"

print(http_message)