#!/usr/bin/env python3
import requests

response = requests.post("http://localhost:7201/alpha", data={"alpha": 1})


print(response.text)
