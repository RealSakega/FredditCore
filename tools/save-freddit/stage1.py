# python script that: 
# 1. takes a subreddit name as an argument
# 2. visits said subreddit, downloads the HTML
# 3. finds the "next" button (rel="nofollow next", test "next") and follows it
#  repeat step 3 until there is no "next" button
# names of files should be the page number dot html

import requests
import json
import time
import os
import random
import sys
from bs4 import BeautifulSoup

subreddit = sys.argv[1]

url = f'https://old.reddit.com/r/{subreddit}/'

sleep_timer = 3 # should be safe

headers = {'User-Agent': 'Mozilla/5.0 (Android 4.4; Mobile; rv:41.0) Gecko/41.0 Firefox/41.0'}

page = 0

post_urls = []

reddit_url = 'https://old.reddit.com/r/'

def write_json(data, filename):
    # format json into newlines
    with open(filename, 'w') as f:
        f.write(json.dumps(data, indent=4))

while True:
    try:
        page += 1

        response = requests.get(url, headers=headers)
        html = response.text

        print(response)

        #remove non-ascii characters
        html = ''.join([i if ord(i) < 128 else ' ' for i in html])

        with open(f'out/pages/{page}.html', 'w') as f:
            f.write(html)

        soup = BeautifulSoup(html, 'html.parser')

        # find all post links (with the following format: */r/subreddit_name/comments/*)
        post_links = soup.find_all('a', href=True)
        post_links = [link['href'] for link in post_links if reddit_url + subreddit + '/comments/' in link['href']]
        post_urls += post_links

        print(f'Page {page} done. {len(post_links)} links found.')

        next_button = soup.find('a', rel='nofollow next')
        if not next_button:
            break

        url = next_button['href']

        # Delay spoofing
        sleep_timer_random = sleep_timer + random.uniform(-1, 1)
        time.sleep(sleep_timer_random) 
    
    except KeyboardInterrupt:        
        write_json(post_urls, f'out/{subreddit}.json')
        sys.exit(0)

write_json(post_urls, f'out/{subreddit}.json')