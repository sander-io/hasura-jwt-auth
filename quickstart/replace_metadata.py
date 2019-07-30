import json
from urllib.request import Request, urlopen

def post(url, payload):
    request = Request(url, json.dumps(payload), {
        "x-hasura-admin-secret": "adminsecret",
        "content-type": "application/json; charset=utf-8",
    })
    data = json.dumps(payload).encode("utf-8")
    resp = urlopen(request, data)
    return json.loads(resp.read())

with open("metadata.json") as file:
    metadata = json.load(file)
    result = post("http://localhost:8080/v1/query", {
        "type": "replace_metadata",
        "args": metadata,
    })
    print(result)
