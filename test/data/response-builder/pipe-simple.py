#!/usr/bin/env python3
import sys
import json

print("x-adms-status-code: 202\n")

resp = {
    'response': sys.argv[0],
    'requested-uri': sys.argv[1]
}

print(json.dumps(resp))