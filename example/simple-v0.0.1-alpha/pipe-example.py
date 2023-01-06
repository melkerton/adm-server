#!/usr/bin/env python3
import sys
import json

print("x-adms-status-code: 200\n")

object = {
    'response': sys.argv[0],
    'requested-uri': sys.argv[1]
}

print(json.dumps(object))
# empty last line
print("")