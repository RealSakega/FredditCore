import src.collect_posts as collect_posts
import src.collect_post_pages as collect_post_pages
import src.collect_images as collect_images

import os
import sys

# ARGS: subreddit, output_dir. Optional (--): --save_json, --collect_posts, --collect_post_pages, --collect_images

subreddit = sys.argv[1]
output_dir = sys.argv[2] if len(sys.argv) > 2 and sys.argv[2][:2] != '--' else f'out/{subreddit}'

# make output dirs if non-existent
if not os.path.exists(output_dir):
    os.makedirs(output_dir)
if not os.path.exists(f'{output_dir}/pages'):
    os.makedirs(f'{output_dir}/pages')
if not os.path.exists(f'{output_dir}/posts'):
    os.makedirs(f'{output_dir}/posts')
if not os.path.exists(f'{output_dir}/images'):
    os.makedirs(f'{output_dir}/images')

# optional args
save_json = False

if '--save_json' in sys.argv:
    save_json = True

stage1 = True
stage2 = True
stage3 = True

if "--stages" in sys.argv:
    stage1, stage2, stage3 = False, False, False

if '--collect_posts' in sys.argv:
    stage1 = True

if '--collect_post_pages' in sys.argv:
    stage2 = True

if '--collect_images' in sys.argv:
    stage3 = True

# collect posts
if stage1:
    collect_posts.collect_posts(subreddit, output_dir, save_json=True) 
if stage2:
    collect_post_pages.collect_post_pages(subreddit, output_dir)
if stage3:
    collect_images.collect_images(output_dir, subreddit)
