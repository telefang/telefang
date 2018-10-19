from __future__ import unicode_literals

import csv
import os
import re
import requests
from io import BytesIO, open
from PIL import Image

from flask import Flask, request, Response

# Currently, everything is fairly intertwined with the web app
# (using `app` here and there, for example), but if needed
# the preview facilities could be split out into their own module
# with a little bit of finaglin'.

BACKGROUND_COLOR = (249, 214,  83, 255)
FOREGROUND_COLOR = ( 55,  55,  55, 255)

DATA_DIR = 'data'

CHARMAP_URL = 'https://raw.githubusercontent.com/telefang/telefang/patch/charmap.asm'
FONTS = {
    'normal': {
        'metrics': 'https://raw.githubusercontent.com/telefang/telefang/patch/components/mainscript/font.tffont.csv',
        'image': 'https://raw.githubusercontent.com/telefang/telefang/patch/gfx/font.png'
    },
    'bold': {
        'metrics': 'https://raw.githubusercontent.com/telefang/telefang/patch/components/mainscript/font_bold.tffont.csv',
        'image': 'https://raw.githubusercontent.com/telefang/telefang/patch/gfx/bold_font.png'
    },
    'narrow': {
        'metrics': 'https://raw.githubusercontent.com/telefang/telefang/patch/components/mainscript/font_narrow.tffont.csv',
        'image': 'https://raw.githubusercontent.com/telefang/telefang/patch/gfx/narrow_font.png'
    }
}

app = Flask(__name__)

@app.before_first_request
def setup():
    try:
        load()
    except IOError:
        update()

@app.route('/preview')
def preview():
    width = min(int(request.args['width']), 32 * 8)
    text = request.args['text']
    scale = int(request.args.get('scale', 2))
    padding = int(request.args.get('padding', 0))

    image = preview_image(text, width, scale, padding)
    png_data = BytesIO()
    image.save(png_data, format='PNG')

    return Response(png_data.getvalue(), mimetype='image/png')

def preview_image(text, width, scale=1, padding=0):
    # No text formatting, since the JavaScript part takes care of that.
    lines = text.split('\n')
    image = Image.new('RGBA',
                      (padding * 2 + width, padding * 2 + len(lines) * 8),
                      BACKGROUND_COLOR)

    font = app.fonts['normal']
    text_len = len(text)
    i = 0
    x = padding
    y = padding
    while i < text_len:
        for char_len in app.descending_char_lengths:
            char = text[i:i + char_len]
            try:
                code = app.charmap[char]
            except LookupError:
                continue
            else:
                break
        else:
            raise ValueError("Character not in charset.")
        
        if char == '\n':
            x = padding
            y += 8
        else:
            glyph_width = font['metrics'][code]
            glyph = font['glyphs'][code]
            if x + 8 > padding + width:
                glyph = glyph.crop((0, 0, max(padding + width - x, 0), 8))
            image.alpha_composite(glyph, (x, y))
            x += glyph_width + 1

        i += char_len

    if scale != 1:
        image = image.resize((image.width * scale, image.height * scale))

    return image


@app.route('/update', methods=('POST',))
def update():
    """Update font data from online and save to disk."""
    # Split up into three steps to minimize the risk of files being
    # desynced in relation to each other if any part errors out.

    # Fetch resources.
    r = requests.get(CHARMAP_URL)
    raw_charmap = r.text

    raw_metric_csvs = []
    for font_name, font_info in FONTS.items():
        r = requests.get(font_info['metrics'])
        filename = 'font_{}.ttfont.csv'.format(font_name)
        raw_metric_csvs.append((filename, r.text))

    raw_images = []
    for font_name, font_info in FONTS.items():
        r = requests.get(font_info['image'])
        filename = 'font_{}.png'.format(font_name)
        raw_images.append((filename, r.content))
    
    # Store resources.
    with open(os.path.join(DATA_DIR, 'charmap.asm'), 'w', encoding='utf-8') as f:
        f.write(raw_charmap)

    for font_name, csv, image in zip(FONTS.keys(), raw_metric_csvs, raw_images):
        with open(os.path.join(DATA_DIR, csv[0]), 'w', encoding='utf-8') as f:
            f.write(csv[1])
        with open(os.path.join(DATA_DIR, image[0]), 'wb') as f:
            f.write(image[1])

    # Put resources into use.
    app.charmap = parse_charmap(raw_charmap)
    app.descending_char_lengths = descending_char_lengths_of(app.charmap)
    app.fonts = {}
    for font_name, csv, image in zip(FONTS.keys(), raw_metric_csvs, raw_images):
        app.fonts[font_name] = {
            'metrics': parse_metric_csv(csv[1]),
            'glyphs': load_glyphs(BytesIO(image[1]))
        }
    
    return "Nice yeah sure it's all cool", 200

def load():
    """Load font data from disk."""
    with open(os.path.join(DATA_DIR, 'charmap.asm'), 'r', encoding='utf-8') as f:
        app.charmap = parse_charmap(f.read())
        app.descending_char_lengths = descending_char_lengths_of(app.charmap)
    app.fonts = {}
    for font_name in FONTS.keys():
        with open(os.path.join(DATA_DIR, 'font_{}.ttfont.csv'.format(font_name)), 'r', encoding='utf-8') as f:
            metrics = parse_metric_csv(f.read())
        with open(os.path.join(DATA_DIR, 'font_{}.png'.format(font_name)), 'rb') as f:
            glyphs = load_glyphs(f)
        app.fonts[font_name] = {
            'metrics': metrics,
            'glyphs': glyphs
        }

# The """ charmap is actually incorrect RGBDS code, but exists
# in Telefang's charmap file since it goes through a Python
# script and never actually through RGBDS.
CHARMAP_RE = re.compile(r'^(?:charmap "(?P<char>"|[^"]+)",\s*(?P<prefix>|\$|%|&)(?P<code>[0-9A-Fa-f]+))?\s*(?:;.*)?$')
def parse_charmap(s):
    """Parse charmap assembly and return a dictionary
    of {character: code} pairs.
    """
    charmap = {}
    for line in s.splitlines():
        m = CHARMAP_RE.match(line)
        if not m.group('char'):
            continue
        char = m.group('char')
        if char == '\\n':
            char = '\n'
        code = int(m.group('code'), {'': 10, '$': 16, '%': 2, '&': 8}[m.group('prefix')])
        charmap[char] = code
    return charmap

def descending_char_lengths_of(charmap):
    """Return a list of the different character lengths
    (e.g. "x" has a length of 1; "<code>" is 6) in descending order.
    """
    lengths = set()
    for char in charmap:
        lengths.add(len(char))
    return sorted(lengths, reverse=True)

def parse_metric_csv(s):
    """Return a list of glyph widths found in the metric CSV data in `s`."""
    reader = csv.reader(s.splitlines())
    rows = [row for row in reader]
    rows = rows[1:] # Strip header row.
    rows = [row[1:] for row in rows] # Strip header column.
    widths = [width for row in rows for width in row]
    widths = [int(width[1:], 16) for width in widths]
    return widths

def load_glyphs(f):
    """Return a list of 8×8 glyph images, found in the image file `f`."""
    image = Image.open(f)
    image.convert('RGBA')
    data = list(image.getdata())
    for i, (r, g, b, a) in enumerate(data):
        if (r, g, b) == (255, 255, 255):
            data[i] = (r, g, b, 0)
    image.putdata(data)

    glyphs = []
    for y in range(0, image.height, 8):
        for x in range(0, image.width, 8):
            glyphs.append(image.crop((x, y, x + 8, y + 8)))

    return glyphs

if __name__ == '__main__':
    app.run('localhost', debug=True)
