#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Color a PNG using a Game Boy Color palette.

from __future__ import unicode_literals
from __future__ import print_function

import struct
import sys
from binascii import crc32
from io import BytesIO
from PIL import Image
from PIL.ImagePalette import ImagePalette

def parse_palette(palette_bytes):
    """Parse a Game Boy Color 2-bytes-per-color palette.
    Return a list of four tuples of RGB between 0 and 255.
    """
    palette_bytes = BytesIO(palette_bytes)
    colors = []
    for i in range(4):
        entry = struct.unpack('<H', palette_bytes.read(2))[0]
        blue  = ((entry & 0b0111110000000000) >> 10) * 8
        green = ((entry & 0b0000001111100000) >>  5) * 8
        red   =  (entry & 0b0000000000011111)        * 8
        if (red, green, blue) == (248, 248, 248):
            # For a whiter white. 9/10 dentists recommend.
            red, green, blue = 255, 255, 255
        colors.append((red, green, blue))
    return colors

def colorize(image, colors):
    """Return `image` with the colors replaced by the ones in `colors`.
    Colors are replaced in order of palette (if indexed) or descending order
    of luminance (if not).

    If PNG palette length is important, you'll have to use truncate_palette
    to remove superfluous colors on the resulting raw PNG bytes, as Pillow
    doesn't support variable-length palettes.
    """
    image = image.convert('RGBA')
    existing_colors = [color for count, color in image.getcolors()]
    if len(existing_colors) > len(colors):
        raise ImageError("Too many colors in image to colorize with the palette.")

    palette = ImagePalette('RGB')
    for color in colors:
        palette.getcolor(color)

    new_image = Image.new('P', image.size)
    new_image.putpalette(palette)

    # In order to be replaced with the correct colors in the palette,
    # the existing colors have to be sorted by luminance.
    key = lambda color: (0.2126 * color[0] + 0.7152 * color[1] + 0.0722 * color[2])
    existing_colors = sorted(existing_colors, key=key, reverse=True)
    color_indexes = {color: i for i, color in enumerate(existing_colors)}

    data = [color_indexes[pixel_color] for pixel_color in image.getdata()]
    new_image.putdata(data)

    return new_image

def truncate_palette(png_bytes, num_colors):
    """Truncate the PLTE chunk in the raw PNG in `png_bytes` to only
    `num_colors` colors and return the resulting bytes.
    """
    stream = BytesIO(png_bytes)
    stream.read(8) # PNG header
    chunk_length = struct.unpack('>L', stream.read(4))[0]
    chunk_name = stream.read(4)
    while chunk_name:
        stream.read(chunk_length + 4)
        chunk_start = stream.tell()
        chunk_length = struct.unpack('>L', stream.read(4))[0]
        chunk_name = stream.read(4)
        if chunk_name == b'PLTE':
            break
    else:
        return png_bytes

    chunk_end = chunk_start + 4 + 4 + chunk_length + 4
    
    new_chunk_length = min(chunk_length, num_colors * 3)
    palette_data = stream.read(chunk_length)[:new_chunk_length]
    new_checksum = crc32(b'PLTE' + palette_data)

    return (png_bytes[:chunk_start] +
            struct.pack('>L', new_chunk_length) +
            b'PLTE' +
            palette_data +
            struct.pack('>L', new_checksum) +
            png_bytes[chunk_end:])

def main():
    try:
        palette_path = sys.argv[1]
        image_path = sys.argv[2]
    except IndexError:
        print("Usage: colorize_png.py <palette file> <PNG to colorize>")
        print("For example: colorize_png.py fungus.gbcpal fungus.png")
        sys.exit(1)
    
    print("Colorizing {} using {}...".format(image_path, palette_path))

    with open(palette_path, 'rb') as f:
        colors = parse_palette(f.read())
    
    image = Image.open(image_path)

    try:
        image = colorize(image, colors)
    except ValueError:
        raise
        print("Too many colors in the image to colorize using the provided palette.")
        sys.exit(1)
    

    # Having to fix the PLTE chunk in post isn't particularly fast, but since
    # this isn't run on compile time, it's not too performance-critical.
    png_bytes = BytesIO()
    image.save(png_bytes, 'PNG')
    png_bytes = truncate_palette(png_bytes.getvalue(), len(colors))
    with open(image_path, 'wb') as f:
        f.write(png_bytes)

if __name__ == '__main__':
    main()
