import requests
import json
import time
import os
import random

from bs4 import BeautifulSoup

# take filename as an argument
import sys

input_filename = sys.argv[1]

with open(input_filename, 'r') as f:
    posts = json.load(f)

sleep_timer = 1 # should be safe

headers = {'User-Agent': 'Mozilla/5.0 (Android 4.4; Mobile; rv:41.0) Gecko/41.0 Firefox/41.0'}

i = 0

for url in posts:
    i += 1
    url = url.replace('https://www.reddit.com', 'https://old.reddit.com')

    # Replace any characters that are not allowed in filenames
    title = url.replace('/', '_').replace(':', '_').replace('?', '_').replace('&', '_').replace('=', '_').replace(' ', '_')
    
    # if out file exists, skip
    if os.path.exists(f'out/posts/{title}.html'):
        print('File exists, skipping.')
        continue

    response = requests.get(url, headers=headers)
    html = response.text

    print(url, response)

    #remove non-ascii characters
    html = ''.join([i if ord(i) < 128 else ' ' for i in html])


    # find all data-type="comment" elements, find usertext-body children, and extract text
    soup = BeautifulSoup(html, 'html.parser')
    post_contents = soup.find_all('div', {'data-type': 'comment'})
    post_contents = [content.find('div', {'class': 'usertext-body'}).get_text() for content in post_contents]

    print(f'Found {len(post_contents)} comments.')
    
    print(post_contents)

    with open(f'out/posts/{title}.html', 'w') as f:
        f.write(html)


    print(f"{i}/{len(posts)}")


    # Delay spoofing
    sleep_timer_random = sleep_timer + random.uniform(-1, 1)
    time.sleep(sleep_timer_random) 
