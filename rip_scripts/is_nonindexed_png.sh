#!/bin/bash
# Return 0 if the provided file is a non-indexed PNG, 1 if not.
# Needed because rgbgfx may give unexpected results when fed a PNG in indexed mode.

if [ $# != 1 ]; then
    echo "Please provide a path to a file to check."
    exit 1
fi

if [ "$(od -A n -t x1 -j 25 -N 1 $1)" != " 03" ]; then
    exit 0
else
    if [ -r $1 ]; then
        echo "$1 is an indexed PNG. Please convert it to truecolor or grayscale."
    fi
    exit 1
fi
