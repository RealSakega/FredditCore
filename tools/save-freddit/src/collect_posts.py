import requests
import json
import time
import random
import sys
from bs4 import BeautifulSoup

sleep_timer = 3 # should be safe
headers = {'User-Agent': 'Mozilla/5.0 (Android 4.4; Mobile; rv:41.0) Gecko/41.0 Firefox/41.0'}

def write_json(data, filename):
    with open(filename, 'w') as f:
        f.write(json.dumps(data, indent=4))

def collect_posts(subreddit, output_dir, save_json=False):
    
    output_filename = f'{output_dir}/post_urls.json'
    post_urls = []
    base_reddit_url = f'https://old.reddit.com'
    reddit_url = base_reddit_url + f'/r/{subreddit}'
    params = ""
    
    page = 0
    pages = 0

    while True:
        try:
            page += 1

            response = requests.get(reddit_url + "/.json" + params, headers=headers)
            json_data = response.json()

            if save_json:
                with open(f'{output_dir}/pages/{pages}.json', 'w') as f:
                    f.write(json.dumps(json_data, indent=4))

            for c in json_data['data']['children']:
                post_urls.append(base_reddit_url + c['data']['permalink'])

            print(f'Page {page} done. {len(post_urls)} links found.')

            pages += 25

            after = json_data['data']['after']

            if after is None:
                break

            params = f"?count={pages}&after={after}"
            print(params)

            # Delay spoofing
            sleep_timer_random = sleep_timer + random.uniform(-1, 1)
            time.sleep(sleep_timer_random) 
        
        except KeyboardInterrupt:        
            write_json(post_urls, output_filename)
            sys.exit(0)
        
    write_json(post_urls, output_filename)

    return True