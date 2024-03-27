import src.collect_posts as collect_posts
import src.collect_post_pages as collect_post_pages
import src.parse_post_pages as parse_post_pages

import sys

subreddit = sys.argv[1]
output_dir = sys.argv[2] if len(sys.argv) > 2 else 'out'

# collect posts
collect_posts.collect_posts(subreddit, output_dir)
collect_post_pages.collect_post_pages(f'{output_dir}/{subreddit}.json')