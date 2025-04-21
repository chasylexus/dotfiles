import argparse
import base64
from bs4 import BeautifulSoup

# Create an ArgumentParser object
parser = argparse.ArgumentParser(description='Process some integers.')

# Add arguments
parser.add_argument('input_file', type=str)
parser.add_argument('output_file', type=str)

# Parse arguments
args = parser.parse_args()

input_file = args.input_file
output_file = args.output_file

html = open(input_file, 'r', encoding='utf-8').read()
soup = BeautifulSoup(html, 'html.parser')

for img in soup.find_all('img'):
    src = img['src']
    if not src.startswith('data:'):
        with open(src, 'rb') as f:
            data = f.read()
        mime = 'image/' + src.rsplit('.',1)[-1]
        b64 = base64.b64encode(data).decode()
        img['src'] = f'data:{mime};base64,{b64}'

with open(output_file, 'w', encoding='utf-8') as f:
    f.write(str(soup))
