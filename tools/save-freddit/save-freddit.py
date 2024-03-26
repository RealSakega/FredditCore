import requests
import json
import time
import os
import random

with open('posts.json', 'r') as f:
    posts = json.load(f)

sleep_timer = 6 # should be safe

headers = {'User-Agent': 'Mozilla/5.0 (Android 4.4; Mobile; rv:41.0) Gecko/41.0 Firefox/41.0'}

for url in posts:
    url = url.replace('https://www.reddit.com', 'https://old.reddit.com')

    response = requests.get(url, headers=headers)
    html = response.text

    #remove non-ascii characters
    html = ''.join([i if ord(i) < 128 else ' ' for i in html])

    # Replace any characters that are not allowed in filenames
    title = url.replace('/', '_').replace(':', '_').replace('?', '_').replace('&', '_').replace('=', '_').replace(' ', '_')

    with open(f'out/{title}.html', 'w') as f:
        f.write(html)

    # Delay spoofing
    sleep_timer_random = sleep_timer + random.uniform(-1, 1)
    time.sleep(sleep_timer_random) 
