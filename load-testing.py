import requests

while True:

    print(requests.get('http://35.189.10.105:8000/').json())
