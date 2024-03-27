# prettify html files in out/posts

import json
import os
import sys
from bs4 import BeautifulSoup

input_dir = sys.argv[1]


# recursively gather replies to comments
def get_replies(comment):
    replies = comment.find_all('div', {'class': 'comment'})
    replies = [{
        'author': reply.find('a', {'class': 'author'}).get_text() if reply.find('a', {'class': 'author'}) else '[deleted]',
        'date': reply.find('time')['datetime'],
        'text': reply.find('div', {'class': 'usertext-body'}).get_text(),
        'replies': get_replies(reply)
    } for reply in replies]
    return replies


for filename in os.listdir(input_dir):
    # skip if gitignore or directory
    if filename == '.gitignore' or os.path.isdir(os.path.join(input_dir, filename)):
        continue

    print(filename)

    with open(os.path.join(input_dir, filename), 'r') as f:
        html = f.read()

    soup = BeautifulSoup(html, 'html.parser')

    html_pretty = soup.prettify()
    html_pretty = ''.join([i if ord(i) < 128 else ' ' for i in html_pretty])

    post_content = soup.find('div', {'class': 'linklisting'})
    if not post_content:
        print('No post content found.')
        continue
    post_title = post_content.find('a', {'class': 'title'}).get_text()
    post_text = post_content.find('div', {'class': 'usertext-body'})
    post_author = post_content.find('a', {'class': 'author'})
    post_url = post_content.find('a', {'class': 'title'})['href']
    post_text = post_text.get_text() if post_text else ''
    post_author = post_author.get_text() if post_author else '[deleted]'
    post_date = post_content.find('time')['datetime']
    print(post_title, post_text)

    # grab commentarea div
    commentarea = soup.find('div', {'class': 'commentarea'})
    if not commentarea:
        print('No comment area found.')
        exit()

    # grab all comments (but ignore children of comments)
    comments = commentarea.find_all('div', {'class': 'comment'})
    comments = [{
        'author': comment.find('a', {'class': 'author'}).get_text() if comment.find('a', {'class': 'author'}) else '[deleted]',
        'date': comment.find('time')['datetime'],
        'text': comment.find('div', {'class': 'usertext-body'}).get_text(),
        'replies': get_replies(comment)
    } for comment in comments]
    

    post_json = {
        'title': post_title,
        'url': post_url,
        'text': post_text,
        'author': post_author,
        'date': post_date,
        'comments': comments,
    }

    with open(os.path.join(input_dir + '/json', filename + '.json'), 'w') as f:
        f.write(json.dumps(post_json, indent=4))
