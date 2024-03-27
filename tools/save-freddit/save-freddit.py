import src.collect_posts as collect_posts
import src.collect_post_pages as collect_post_pages
import src.parse_post_pages as parse_post_pages

import os
import sys

subreddit = sys.argv[1]
output_dir = sys.argv[2] if len(sys.argv) > 2 else f'out/{subreddit}'

# make output dirs if non-existent
if not os.path.exists(output_dir):
    os.makedirs(output_dir)
if not os.path.exists(f'{output_dir}/pages'):
    os.makedirs(f'{output_dir}/pages')
if not os.path.exists(f'{output_dir}/posts'):
    os.makedirs(f'{output_dir}/posts')

# collect posts
collect_posts.collect_posts(subreddit, output_dir, save_json=True)
collect_post_pages.collect_post_pages(subreddit, output_dir)