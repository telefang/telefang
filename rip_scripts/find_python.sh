#!/bin/bash

#Some platforms install Python3 as "python3", others install it as "python".
if hash python3 2>/dev/null; then
    python3 "$@"
else
    python "$@"
fi
