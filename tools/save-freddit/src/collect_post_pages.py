import requests
import json
import time
import os
import random


def collect_post_pages(subreddit, output_dir):
    with open(f'{output_dir}/post_urls.json', 'r') as f:
        posts = json.load(f)

    sleep_timer = 1 # should be safe

    headers = {'User-Agent': 'Mozilla/5.0 (Android 4.4; Mobile; rv:41.0) Gecko/41.0 Firefox/41.0'}

    i = 0

    for url in posts:
        i += 1
        url = url.replace('https://www.reddit.com', 'https://old.reddit.com')

        # Replace any characters that are not allowed in filenames
        title = url.replace('/', '_').replace(':', '_').replace('?', '_').replace('&', '_').replace('=', '_').replace(' ', '_')

        # clean title
        title = title.replace(f'https___old.reddit.com_r_{subreddit}_comments_', '')
        
        # if out file exists, skip
        if os.path.exists(f'out/posts/{title}.json'):
            print('File exists, skipping.')
            continue

        response = requests.get(url + '.json', headers=headers)
        json_data = response.json()

        print(url, response)

        with open(f'{output_dir}/posts/{title}.json', 'w') as f:
            f.write(json.dumps(json_data, indent=4))

        print(f"{i}/{len(posts)}")

        # Delay spoofing
        sleep_timer_random = sleep_timer + random.uniform(-1, 1)
        time.sleep(sleep_timer_random) 
