#!/bin/bash

# Some platforms install Python3 as "python3", others install it as "python".

for current_command in python3 python
do
    if [[ $($current_command --version 2> /dev/null | grep "^Python 3\.") ]]; then
        echo $current_command
        exit 0
    fi
done

exit 1
